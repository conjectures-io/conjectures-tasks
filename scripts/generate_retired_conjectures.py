#!/usr/bin/env python3
"""Rebuild the display payload for retired conjectures from git history.

A retired target is removed from `allowlist.json` and its bundle directories are deleted, which
is what closes it to submission. But everything the public catalog renders — statement,
docstring, references, AMS subjects, `Challenge.lean` — lives *inside* those bundles, so deleting
them also erases the problem from the website. The two concerns are separate: a target should
stop accepting submissions the moment it is retired, and stay readable forever so its results and
attribution remain citable.

This script closes that gap without weakening the deny-by-default boundary. It recovers each
retired bundle from the commit that deleted it and writes the display fields to
`tiers/tier-1/retired-conjectures.json`. Nothing it emits is ever consulted by task admission:
the API loads it into a separate read-only index, and `allowed_task_bundles` never sees it.

Regenerate after every retirement, then refresh `retired_conjectures_sha256` in the tier policy.
The output is deterministic, so a rerun with no new retirement is a no-op diff.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
from pathlib import Path

TASKS_ROOT = Path(__file__).resolve().parent.parent
TIER_NAME = "tier-1"
SCHEMA_VERSION = 1

# `git log -- <path>` applies history simplification and silently skips commits that deleted a
# path on a side of the history it decides is uninteresting. Without --full-history the earliest
# retirement round goes missing and the manifest comes out quietly incomplete.
DELETED_BUNDLES = (
    "log", "--full-history", "--diff-filter=D",
    "--format=COMMIT %H", "--name-only", "--", f"pool/{TIER_NAME}/*/manifest.json",
)

# `- `Theorem.name` — 2026-08-06 — `CODE (detail)``
RETIREMENT_LINE = re.compile(
    r"^-\s+`(?P<theorem>[^`]+)`\s+—\s+(?P<date>\d{4}-\d{2}-\d{2})\s+—\s+`(?P<reason>.+)`\s*$"
)
# Everything before the first parenthesised detail is the code, e.g. `SOURCE_MISMATCH + EXPLOITABLE`.
REASON_CODE = re.compile(r"^(?P<code>[^(]+?)\s*(?:\(|$)")

REWARD_TARGET_PREFIX = "fc-target:"

DECISIONS_BASE = (
    "https://github.com/conjectures-io/conjectures-validator/blob/main/docs/review-decisions"
)
# Only targets whose retirement was decided under the manual reward-review policy have a
# published rationale. A dependency or audit retirement has none, and null is the honest answer.
DECISIONS = {
    "Erdos15.erdos_15": "2026-08-05-erdos-15.md",
    "Erdos10.erdos_10.variants.grechuk": "2026-08-06-erdos-10-grechuk.md",
    "Erdos939.erdos_939": "2026-08-06-erdos-939.md",
    "Green42.green_42": "2026-08-06-green-42.md",
    "Green29.green_29": "2026-08-06-green-29.md",
}


class GeneratorError(RuntimeError):
    """The retired set cannot be reconstructed from the repository as it stands."""


def git(*arguments: str) -> str:
    result = subprocess.run(
        ("git", "-C", str(TASKS_ROOT), *arguments),
        capture_output=True,
        text=True,
        check=False,
    )
    if result.returncode != 0:
        raise GeneratorError(f"git {' '.join(arguments)} failed: {result.stderr.strip()}")
    return result.stdout


def read_before(commit: str, path: str) -> str:
    """The file as it stood in the parent of `commit` — i.e. just before it was deleted."""
    return git("show", f"{commit}~1:{path}")


def retirement_log() -> dict[str, dict[str, str]]:
    """Theorem -> retirement date and reason, from the human-authored log."""
    path = TASKS_ROOT / "tiers" / TIER_NAME / "RETIREMENTS.md"
    entries: dict[str, dict[str, str]] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.startswith("- "):
            continue
        match = RETIREMENT_LINE.match(line)
        if match is None:
            raise GeneratorError(f"unparsable retirement entry: {line}")
        theorem = match.group("theorem")
        if theorem in entries:
            raise GeneratorError(f"duplicate retirement entry for {theorem}")
        reason = match.group("reason")
        code = REASON_CODE.match(reason)
        entries[theorem] = {
            "retired_on": match.group("date"),
            "reason_code": code.group("code") if code else reason,
            "reason": reason,
        }
    if not entries:
        raise GeneratorError("RETIREMENTS.md lists no retirements")
    return entries


def deleted_bundles() -> dict[str, str]:
    """Bundle directory name -> the commit that deleted it."""
    found: dict[str, str] = {}
    commit = ""
    for line in git(*DELETED_BUNDLES).splitlines():
        line = line.strip()
        if line.startswith("COMMIT "):
            commit = line.removeprefix("COMMIT ")
        elif line.endswith("/manifest.json"):
            directory = line.split("/")[2]
            # git log walks newest first; a directory deleted, restored and deleted again should
            # be read from its most recent removal, so keep the first sighting.
            found.setdefault(directory, commit)
    if not found:
        raise GeneratorError("no deleted task bundles found in history")
    return found


def bundle_before(commit: str, directory: str) -> dict[str, object]:
    """The manifest, source metadata and challenge text as they stood before deletion.

    The challenge text is checked against the digest the manifest published for it, so what the
    website eventually renders is provably the audited bytes and not something a later edit to
    history reshaped. A bundle is immutable by construction; this is what makes that claim
    survive the bundle's own deletion.
    """
    base = f"pool/{TIER_NAME}/{directory}"
    manifest = json.loads(read_before(commit, f"{base}/manifest.json"))
    challenge = read_before(commit, f"{base}/Challenge.lean")
    published = manifest["trusted_file_hashes"]["Challenge.lean"]
    recovered = "sha256:" + hashlib.sha256(challenge.encode("utf-8")).hexdigest()
    if recovered != published:
        raise GeneratorError(
            f"{directory}/Challenge.lean recovered from {commit[:8]}~1 hashes to {recovered}, "
            f"but its manifest published {published}"
        )
    return {
        "manifest": manifest,
        "source": json.loads(read_before(commit, f"{base}/source-metadata.json")),
        "challenge_lean": challenge,
    }


def allowlist_before(commit: str) -> dict[str, object]:
    return json.loads(read_before(commit, "allowlist.json"))


def build() -> dict[str, object]:
    log = retirement_log()
    bundles = deleted_bundles()

    # theorem -> {"tasks": [...], "source": {...}, "commit": ...}
    grouped: dict[str, dict[str, object]] = {}
    for directory, commit in bundles.items():
        recovered = bundle_before(commit, directory)
        manifest = recovered["manifest"]
        theorem = manifest["source_theorem"]
        if theorem not in log:
            raise GeneratorError(
                f"{directory} was deleted at {commit[:8]} but {theorem} is not in RETIREMENTS.md"
            )
        entry = grouped.setdefault(theorem, {"tasks": [], "source": recovered["source"], "commit": commit})
        if entry["source"] != recovered["source"]:
            raise GeneratorError(f"{theorem} bundles disagree about their source metadata")

        allowlist = allowlist_before(commit)
        allowed = {
            row["task_id"]: row
            for row in allowlist["allowed_task_bundles"]
            if theorem in row["theorems"]
        }
        row = allowed.get(manifest["task_id"])
        if row is None:
            raise GeneratorError(
                f"{manifest['task_id']} was not allowlisted at {commit[:8]}~1"
            )
        entry["tasks"].append(
            {
                "task_id": manifest["task_id"],
                "task_mode": manifest["task_mode"],
                "problem_id": row["problem_id"],
                "task_bundle_sha256": row["task_bundle_sha256"],
                "target_type_sha256": row["target_type_sha256s"][0],
                "challenge_lean": recovered["challenge_lean"],
            }
        )
        entry["tier"] = row["tier"]

    retired = []
    for theorem in sorted(grouped):
        entry = grouped[theorem]
        decision = DECISIONS.get(theorem)
        retired.append(
            {
                "reward_target_id": REWARD_TARGET_PREFIX + theorem,
                "theorem": theorem,
                "tier": entry["tier"],
                "retired_on": log[theorem]["retired_on"],
                "reason_code": log[theorem]["reason_code"],
                "reason": log[theorem]["reason"],
                "decision_url": f"{DECISIONS_BASE}/{decision}" if decision else None,
                "recovered_from_commit": entry["commit"],
                "source": entry["source"],
                "tasks": sorted(entry["tasks"], key=lambda task: task["task_mode"]),
            }
        )

    commits = {item["source"]["repository_commit"] for item in retired}
    if len(commits) != 1:
        raise GeneratorError(f"retired bundles span several source revisions: {sorted(commits)}")

    return {
        "schema_version": SCHEMA_VERSION,
        "repository_commit": commits.pop(),
        "retired": retired,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output",
        type=Path,
        default=TASKS_ROOT / "tiers" / TIER_NAME / "retired-conjectures.json",
    )
    parser.add_argument(
        "--check",
        action="store_true",
        help="fail if the file on disk differs from what this run would write",
    )
    arguments = parser.parse_args()

    content = (json.dumps(build(), indent=2, sort_keys=True, ensure_ascii=False) + "\n").encode()

    if arguments.check:
        current = arguments.output.read_bytes() if arguments.output.exists() else b""
        if current != content:
            print(f"{arguments.output} is stale; rerun without --check", file=sys.stderr)
            return 1
        print(f"{arguments.output} is up to date")
        return 0

    arguments.output.write_bytes(content)
    payload = json.loads(content)
    print(
        f"wrote {len(payload['retired'])} retired conjectures "
        f"({sum(len(item['tasks']) for item in payload['retired'])} tasks) to {arguments.output}"
    )
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except GeneratorError as error:
        print(f"error: {error}", file=sys.stderr)
        raise SystemExit(2) from error
