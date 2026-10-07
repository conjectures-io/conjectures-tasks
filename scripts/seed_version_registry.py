#!/usr/bin/env python3
"""Create `task-versions.json` for a tasks release that predates it. Run once, at migration.

    python3 scripts/seed_version_registry.py \
        --environment-identity ENVIRONMENT.json [--historical history/legacy/HISTORY.json]

Every bundle in `pool/` that `allowlist.json` admits is registered as a legacy version at one
verification instance: this release's source commit together with the environment identity of
the image that will verify it (`ENVIRONMENT.json`, the `environment` object that image's
`doctor`/derivation reports). Historical legacy bundles preserved under `history/legacy/` are
registered first, each at the instance that originally accepted their paid work, with intake
closed. Nothing is regenerated, and no bundle byte changes: a legacy bundle keeps its task ID,
digest and `problem_id`, so paid submissions made against it keep routing to it.

Refuses to overwrite an existing registry.
"""

from __future__ import annotations

import argparse
import json
import os
import sys
from pathlib import Path

TASKS_ROOT = Path(__file__).resolve().parent.parent
VALIDATOR_ROOT = Path(
    os.environ.get("CONJECTURES_VALIDATOR_ROOT", TASKS_ROOT.parent / "conjectures-validator")
).resolve()
sys.path.insert(0, str(VALIDATOR_ROOT))

from verifier.hashing import sha256_bytes  # noqa: E402
from verifier.task_loader import load_task_bundle  # noqa: E402
from verifier.task_versions import LEGACY_PROVENANCE, EnvironmentIdentity  # noqa: E402
from verifier.version_registry import (  # noqa: E402
    REGISTRY_NAME,
    Instance,
    RegistryBuilder,
    VersionRegistry,
    publish_legacy,
)


def historical(previous: VersionRegistry, spec_path: Path) -> VersionRegistry:
    """Register preserved legacy bundles at the instance that accepted their paid work."""
    spec = json.loads(spec_path.read_text())
    registry = previous
    for entry in spec["instances"]:
        allowlist_path = TASKS_ROOT / entry["allowlist"]
        allowlist = json.loads(allowlist_path.read_text())
        commit = entry["repository_commit"]
        if allowlist.get("repository_commit") != commit:
            raise SystemExit(f"{allowlist_path} is not the allowlist of {commit}")
        rows = {row["task_id"]: row for row in allowlist["allowed_task_bundles"]}
        builder = RegistryBuilder(previous=registry, instance=Instance(commit, None), environment=None)
        for version in entry["versions"]:
            row = rows[version["task_id"]]
            bundle = load_task_bundle(TASKS_ROOT / version["location"])
            if (
                bundle.manifest.task_id != row["task_id"]
                or bundle.sha256 != row["task_bundle_sha256"]
                or bundle.manifest.repository_commit != commit
                or bundle.manifest.task_mode != row["mode"]
                or [source.theorem for source in bundle.sources] != row["theorems"]
            ):
                raise SystemExit(f"{version['location']} is not the bundle {row['task_id']} published")
            builder.admit(
                task_id=row["task_id"],
                task_bundle_sha256=bundle.sha256,
                provenance=LEGACY_PROVENANCE,
                theorem=row["theorems"][0],
                mode=row["mode"],
                tier=row["tier"],
                location=version["location"],
                state=version["state"],
            )
            if builder.versions[row["task_id"]].admissions[0].problem_id != row["problem_id"]:
                raise SystemExit(f"{row['task_id']}: problem ID does not reproduce")
        registry = builder.build(allowlist_sha256=sha256_bytes(allowlist_path.read_bytes()))
    return registry


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--environment-identity", type=Path, required=True)
    parser.add_argument("--historical", type=Path, default=None)
    args = parser.parse_args()
    output = TASKS_ROOT / REGISTRY_NAME
    if os.path.lexists(output):
        raise SystemExit(f"{output} exists; the registry is append-only and is never reseeded")
    environment = EnvironmentIdentity.from_dict(json.loads(args.environment_identity.read_text()))
    registry = VersionRegistry.empty()
    if args.historical is not None:
        registry = historical(registry, args.historical)
    allowlist_path = TASKS_ROOT / "allowlist.json"
    commit = json.loads(allowlist_path.read_text())["repository_commit"]
    locations = {}
    for directory in sorted((TASKS_ROOT / "pool").glob("*/*")):
        if directory.is_dir() and not directory.is_symlink():
            task_id = json.loads((directory / "manifest.json").read_text())["task_id"]
            locations[task_id] = str(directory.relative_to(TASKS_ROOT))
    registry = publish_legacy(
        registry,
        instance=Instance(commit, environment.sha256),
        environment=environment,
        allowlist_path=allowlist_path,
        tasks_root=TASKS_ROOT,
        locations=locations,
    )
    output.write_bytes(registry.to_bytes())
    print(
        json.dumps(
            {
                "registry": str(output),
                "sha256": sha256_bytes(output.read_bytes()),
                "instances": [item.to_dict() for item in registry.instances],
                "publications": len(registry.publications),
                "versions": len(registry.versions),
            },
            indent=2,
        )
    )
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
