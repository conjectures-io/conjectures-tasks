# Conjectures Tasks

Versioned, immutable Lean task bundles for
[`conjectures-validator`](https://github.com/conjectures-io/conjectures-validator).

The validator pins an exact commit of this repository and consumes it as a separate checkout.
For local development, clone `conjectures-validator` and `conjectures-tasks` as sibling
directories, or set `CONJECTURES_TASKS_ROOT` in the validator to this checkout. All active bundles
are organized under readable names below `pool/tier-1/`; each
bundle contains its challenge, manifest, comparator
configuration, trusted hashes, and solution wrapper. The opaque `task_id` inside each manifest is
the stable protocol identity and intentionally does not depend on the directory name.

The current snapshot contains one tier with 328 bundles: proof/refutation pairs for 164 audited
direct propositions (143 Erdős targets and 21 Green's Open Problems targets). The tier label is
retained for compatibility and does not rank or classify the targets.

Published bundles are content-addressed and must not be edited in place. A changed challenge or
configuration requires a new task id and commitment. The deny-by-default allowlist, tier policy,
and selection audits live beside the bundles in this repository; see
[`POOL.md`](POOL.md). The validator pins one exact tasks commit and consumes that release as a unit.

Task selection, bundle generation, pool rebuilding, and fixture generation are owned here under
`scripts/`. Those tools find a sibling `conjectures-validator` checkout by default; set
`CONJECTURES_VALIDATOR_ROOT` when using a different layout.

## Scripts

| Script | What it does |
| --- | --- |
| `rebuild_task_pool.py` | Regenerates the **whole** pool and allowlist from the pinned catalog. Needs the validator's Lean toolchain and takes about an hour. Refuses to overwrite an existing pool or allowlist. Not for retirements — see below. |
| `generate_retired_conjectures.py` | Rebuilds `tiers/tier-1/retired-conjectures.json`, the read-only display payload for targets that have left the pool. Recovers each retired bundle from the commit that deleted it. `--check` fails if the file on disk is stale, so CI can enforce it. |
| `check_task.py` | Fails closed unless a task directory matches the published allowlist. Use it on anything hand-edited. |
| `build_test_pool.py` | Development only: a one-problem pool whose counterexample task is actually provable, so the pipeline can be shown reaching `accepted=true`. The audited pool cannot do that by design. |
| `generate_example_tasks.sh` | Regenerates the documentation examples. |

All JSON in this repository is written as `json.dumps(value, indent=2, sort_keys=True)` plus a
trailing newline. Hand-edits must round-trip through that exactly, because the tier policy publishes
a SHA-256 over the file bytes.

## Retiring a target

A target is retired when it must stop accepting submissions: a formalization that does not
faithfully capture its informal conjecture, a type that depends on an admitted result, or a target a
verified submission has settled. Reasons are recorded in
[`tiers/tier-1/RETIREMENTS.md`](tiers/tier-1/RETIREMENTS.md), and the reward-review decisions behind
them live in the validator's `docs/review-decisions/`.

**Retirement is a surgical edit, never a rebuild.** Running `rebuild_task_pool.py` would regenerate
all remaining bundles and move their digests, breaking content-addressing for submissions already
accepted against them. Delete only what is retired and leave every surviving bundle byte-identical.

Both modes of a target always retire together — one reward identity, one decision.

1. **Delete the bundles.**
   `git rm -r pool/tier-1/<name>-formalized pool/tier-1/<name>-counterexample`
2. **Edit `allowlist.json`.** Drop the `allowed_source_theorems` entry and both
   `allowed_task_bundles` entries, then correct the tier policy counters: `pool_size`,
   `reward_target_count`, `source_theorem_count`, and `minimum_erdos_tasks`.
3. **Record the retirement.** Add the theorem name **and** its `source_type_sha256` to
   `tiers/tier-1/retired-source-theorems.json`, keeping both lists sorted and unique. Membership is
   by name *or* type hash, so a later rename cannot readmit the target.
4. **Drop it from the audit inputs.** Remove the entry from `tiers/tier-1/task-targets.json` and
   from `selection-audit.json`.
5. **Write the log line** in `tiers/tier-1/RETIREMENTS.md`, alphabetically by theorem:
   ``- `Theorem.name` — YYYY-MM-DD — `REASON_CODE (what was wrong, and which submission hit it)` ``
   The generator parses this line, so keep the exact shape.
6. **Update the counts** in this README and in [`POOL.md`](POOL.md).
7. **Commit.** This has to happen before the next step: `generate_retired_conjectures.py` recovers
   the deleted bundles from git history, so the deleting commit must exist first.
8. **Regenerate the display payload** with `python3 scripts/generate_retired_conjectures.py`, then
   refresh `retired_conjectures_sha256` in the tier policy and commit again.
9. **Refresh every other digest you touched.** Each is a plain SHA-256 over the file's bytes:

   | Tier policy field | File |
   | --- | --- |
   | `retired_conjectures_sha256` | `tiers/tier-1/retired-conjectures.json` |
   | `retired_source_theorems_sha256` | `tiers/tier-1/retired-source-theorems.json` |
   | `selection_audit_sha256` | `tiers/tier-1/selection-audit.json` |
   | `task_targets_sha256` | `tiers/tier-1/task-targets.json` |
   | `task_groups_sha256` | `tiers/tier-1/task-groups.json` |

10. **Align the validator.** `DEFAULT_TIER_SIZE` and `MINIMUM_ERDOS_TASKS` in
    `verifier/task_pool.py`, the counts asserted in `tests/test_task_pool.py`, and the figures in its
    `README.md`, `docs/DATA_FLOW.md`, `docs/SUBNET.md`, and `docs/data_flow.mermaid`. The validator's
    test suite reads this checkout directly and fails on any disagreement, which is the intended
    safety net.
11. **Release.** Bump `tasks.commit` in the validator's `pins.lock.json` to the new commit here, then
    deploy: pull the release, `just pin-tasks`, `just restart`. The release and the pin must move
    together — the validator requires the tier-policy fields this commit publishes, and the pin is
    what production actually checks out.

Before releasing, confirm no submission is still queued against a retiring target. Verified
submissions are unaffected — verification is already recorded — but a queued one fails with
`TaskNotAllowed` once the pin moves, and it is still a paid submission owed a review decision.

## Retired conjectures stay readable

Retiring a target removes it from the pool, which is what closes it to submission. But everything the
public catalog renders — statement, docstring, references, AMS subjects, `Challenge.lean` — lives
inside those bundles, so deleting them would also erase the problem from the website along with the
results and attribution earned against it.

`tiers/tier-1/retired-conjectures.json` closes that gap. It carries the display payload for every
retired target, and the API serves it as a read-only index so a retired problem keeps a page that
shows what it asked, who solved it, and why it closed.

It is deliberately **not** part of `retired-source-theorems.json`. That file is an admission input:
membership in it excludes a theorem from selection. This one is presentation only, and nothing in the
submission or verification path reads it. Keeping them apart is what stops a display concern from
ever widening the deny-by-default boundary — a retired target is readable forever and admissible
never.

Each recovered `Challenge.lean` is checked against the digest its own manifest published, so what the
website renders is provably the audited bytes even though the bundle itself is gone.
