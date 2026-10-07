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

The current snapshot contains one tier with 550 bundles: proof/refutation pairs for 275 audited
direct propositions (17 package-authored research targets, 219 Erdős targets, 32 Wikipedia targets, one Millennium target, and 6 previously solved Green's Open Problems targets). The tier label is
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
| `seed_version_registry.py` | Once, at migration: creates `task-versions.json` from the current allowlist and the preserved history under `history/`. Changes no bundle byte. Refuses to overwrite an existing registry. |

## Task versions and history

`task-versions.json` is the version registry. It records:

- the verification instances (source commit plus environment identity);
- the ordered publications, each naming the exact `allowlist.json` digest it opened;
- every task version ever published, with its state and the instances where it was admitted.

The registry is append-only. Version-2 bundles (`fc-v2-…` task IDs, which commit to the target's
dependency identity and the environment identity rather than to the source commit) live in
`versions/<task_id>/`. They are published with `verifier task publish` from the validator, through
a locked, journaled commit. See the validator's `docs/INCREMENTAL_TASKS.md`.

`history/legacy/` keeps legacy bundles byte-for-byte, together with the allowlist that opened
them, for paid work that still belongs to an older source commit. `HISTORY.json` lists them, and
each is registered at the instance that originally accepted it, with intake closed. The one entry
today is `fc-8432eac9-variants-conjecture-d8e9eeeb54-formalized-v1`. Its bundle and
`8432eac9…/allowlist.json` are identical to `pool/tier-1/green-24-variants-conjecture-formalized/`
and `allowlist.json` at this repository's commit `275ef482`.

Registering a version keeps it addressable for verification. It does not make any particular
submission claimable: the attempt cap and the submission's own state still apply.
`history/environments/` records the environment identities that publications name.

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

A target can instead be **held**: withdrawn from admission pending review of a statement or source
discrepancy or of an unverified resolution claim. The steps are the same, except that the theorem and
its types go into `tiers/tier-1/held-source-theorems.json` (never also into
`retired-source-theorems.json`) and the log line goes into `tiers/tier-1/HOLDS.md`. A held target is
neither solved nor retired; its old tasks stay readable with pool status `held`.

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
   | `held_source_theorems_sha256` | `tiers/tier-1/held-source-theorems.json` |
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
ever widening the deny-by-default boundary — a retired target is readable forever and admissible only after an explicit reinstatement removes the retirement records and restores
both audited modes. Reinstatements are recorded in `tiers/tier-1/REINSTATEMENTS.md`.

Each recovered `Challenge.lean` is checked against the digest its own manifest published, so what the
website renders is provably the audited bytes even though the bundle itself is gone.

On September 30, 2026, the 18 remaining open Green targets (36 bundles) were withdrawn at Ben Green’s request. The six previously solved Green entries and all earlier archived results remain available. Withdrawn targets cannot accept new submissions or be selected again.

On October 6, 2026, nineteen targets left the pool. Three exact targets are retired as externally solved — Erdős 252, Erdős 701, and the `omega_times_two_four` variant of Erdős 70 only — see [`tiers/tier-1/EXTERNAL-SOLUTIONS-2026-10-06.md`](tiers/tier-1/EXTERNAL-SOLUTIONS-2026-10-06.md). Eleven are closed on the release owner's instruction to accept public resolution claims, without independent proof replay — see [`tiers/tier-1/OWNER-ACCEPTED-CLOSURES-2026-10-06.md`](tiers/tier-1/OWNER-ACCEPTED-CLOSURES-2026-10-06.md). Five are held pending review; a held target is neither solved nor retired — see [`tiers/tier-1/HOLDS-2026-10-06.md`](tiers/tier-1/HOLDS-2026-10-06.md). The same release repins the source to Lean 4.35.0-rc2, so every surviving bundle has a new task ID while its reward identity is unchanged. Package-authored research targets 1–30 are staged in [`staged/research-targets/`](staged/research-targets/README.md). 17 of them are admitted to `tier-1` by this release (activation pending owner approval); see [`staged/research-targets/ACTIVATION.md`](staged/research-targets/ACTIVATION.md). The others belong to no tier and cannot be admitted.
