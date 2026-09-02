#!/usr/bin/env python3
"""Repin the checked-in test fixtures to the active source revision.

The fixtures under `fixtures/` are built from the verifier's own `VerifierFixtures.*` theorems
rather than from Formal Conjectures, so a pin rotation does not change what they state. They still
record the revision they were generated against, and `verify` compares a task's
`repository_commit` against the pinned one before it looks at anything else. Left behind, they fail
every verification with `REPOSITORY_COMMIT_MISMATCH` -- which reads as a drifted checkout rather
than as a stale fixture, and which is how this step went missing from the release checklist.

`source-metadata.json` is a trusted file that carries the revision, so its bytes change and every
trusted hash is recomputed. Nothing else in the payload depends on the pin: `Challenge.lean` and
the solution wrapper are derived from the declaration.
"""

from __future__ import annotations

import json
import sys
from pathlib import Path

TASKS_ROOT = Path(__file__).resolve().parent.parent
VALIDATOR_ROOT = Path(
    __import__("os").environ.get(
        "CONJECTURES_VALIDATOR_ROOT", TASKS_ROOT.parent / "conjectures-validator"
    )
).resolve()
sys.path.insert(0, str(VALIDATOR_ROOT))

from verifier.hashing import hash_named_files, pretty_json
from verifier.repository import formal_conjectures_pin
from verifier.task_generator import TRUSTED_NAMES, task_id

FIXTURES = TASKS_ROOT / "fixtures"


def main() -> int:
    commit = formal_conjectures_pin(VALIDATOR_ROOT)
    changed = 0
    for manifest_path in sorted(FIXTURES.glob("*/*/manifest.json")):
        task_dir = manifest_path.parent
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        source_path = task_dir / "source-metadata.json"
        source = json.loads(source_path.read_text(encoding="utf-8"))
        if manifest["repository_commit"] == commit:
            print(f"  up to date  {task_dir.relative_to(TASKS_ROOT)}")
            continue

        manifest["repository_commit"] = commit
        manifest["task_id"] = task_id(
            commit,
            manifest["source_theorem"],
            manifest["task_mode"],
            manifest["adapter_version"],
        )
        source["repository_commit"] = commit
        source_path.write_text(pretty_json(source), encoding="utf-8")

        manifest["trusted_file_hashes"] = hash_named_files(task_dir, TRUSTED_NAMES)
        manifest_path.write_text(pretty_json(manifest), encoding="utf-8")
        (task_dir / "trusted-hashes.json").write_text(
            pretty_json(manifest["trusted_file_hashes"]),
            encoding="utf-8",
        )
        print(f"  repinned    {task_dir.relative_to(TASKS_ROOT)} -> {manifest['task_id']}")
        changed += 1
    print(f"repinned {changed} fixture(s) to {commit}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
