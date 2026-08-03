# Task pool

The checked-in task pool is a deny-by-default set of exact Formal Conjectures
proof and counterexample targets for the production verifier and subnet submission protocol. Tasks
are organized into explicit tiers. The allowlist commits the tier of every source
and bundle, so moving a task between tiers is a reviewed policy change.

## Layout

- `allowlist.json` is the pool-wide, machine-readable admission set.
- `tiers/<tier>/` contains that tier's selection audit and policy inputs.
- [`pool/<tier>/`](https://github.com/conjectures-io/conjectures-tasks/tree/main/pool)
  contains the immutable task bundles in this repository.

The current release has two tiers: `tier-1` for complete numbered statements and `tier-2` for
audited parts and variants. Additional tiers can be added without renaming the pool or weakening
deny-by-default validation.

The current wide candidate count and the policy changes required to reach 500
tasks are documented in [`CANDIDATE_AUDIT.md`](CANDIDATE_AUDIT.md).

The semantic and compilation review of the 42 numbered Erdős sources in the
direct-candidate backlog is documented in
[`candidates/ERDOS_42_FORMALIZATION_AUDIT.md`](candidates/ERDOS_42_FORMALIZATION_AUDIT.md).
The resulting filtered replacement list and upstream correction patch are in
[`candidates/ERDOS_DIRECT_CANDIDATES_CLEAN.md`](candidates/ERDOS_DIRECT_CANDIDATES_CLEAN.md) and
[`candidates/formal-conjectures-erdos-audit-fixes.patch`](candidates/formal-conjectures-erdos-audit-fixes.patch).

## Admission policy

Each admitted theorem target must:

- come from the pinned Formal Conjectures commit;
- be a compiled `research open`, `DIRECT_PROP` theorem;
- have a `formalized` target definitionally equal to the complete source theorem
  type and a `counterexample` target definitionally equal to its logical negation;
- have independently compiled and committed canonical target hashes for both modes;
- contain no `sorryAx` term or answer annotation in its type;
- have no formal-proof metadata or exact collision with a cataloged proved
  theorem;
- satisfy the selection and freshness rules declared by its tier;
- have no cataloged non-admitted proof collision for either `P` or `¬ P`;
- compile and pass the independent `TaskInspector` target check.

Each task contains one exact canonical theorem. Partial results, numbered parts, variants, candidate
bounds, and multi-target bundles are excluded from `tier-1`; `tier-2` admits only the 45 named
parts and variants that passed the semantic audit. Answer wrappers and multi-target bundles remain
excluded from both tiers.

The `tier-1` selection has a separate solver-oriented audit. Every source:

- is an Erdős problem;
- is still marked `research open` on the reviewed upstream `main`;
- belongs to a parent problem marked `open`, `verifiable`, `falsifiable`, or
  `decidable` in the pinned Erdős Problems database;
- has no open upstream pull request resolving or correcting the selected theorem
  at audit time; unrelated source-file changes are recorded;
- has no formal-proof metadata or cataloged proved-type collision;
- has at least one recorded feasibility signal: a compact target, discrete
  domain, finite or finitary structure, partial results in the same source, or a
  standard Mathlib surface.

No Formal Conjectures source family is excluded at the pool level. In particular,
Written on the Wall II conjectures may be included in a future tier after the same
open-status, pull-request, collision, and compiled-target checks. The current
`tier-1` selection happens to contain only Erdős problems.

The pool creates one `formalized`/`counterexample` pair for every admitted theorem.
Both bundles have distinct task IDs and commitments but share one deterministic, source-pinned
`problem_id`. They also carry a stable `reward_family_id` derived from the numbered Erdős problem.
The reward store enforces at most one reward per family, so related parts, variants, parent targets,
and later source repins cannot produce duplicate payouts.
The pool does not extract propositions from answer wrappers or substitute answers.

A counterexample task asks for a kernel-checked proof of `¬ P`. For a universal
conjecture this can normally exhibit a concrete violating witness. For other
logical shapes it is more accurately a refutation and need not expose a
machine-readable witness.

## Scope

`tier-1` contains 58 task bundles covering 29 complete Erdős targets from 29 source files.
`tier-2` contains 90 bundles covering 45 audited parts or variants from 33 source files. Every
bundle has exactly one theorem target. The 74 theorem targets map to 55 stable reward families;
acceptance of any target in a family closes that family's reward.

The GitHub review covered all 281 open pull requests visible at audit time and
excluded selected theorems with an active resolution or correction. A separate
pinned check against the Erdős Problems database excludes parent problems
recorded as solved.

“Plausibly attackable” is a comparative solver-target screen, not a promise.
These checks establish that a task is well-formed, remained upstream-open at the
audit boundary, avoided a known active proof or correction PR, and has a
manageable formal surface. They do not establish that the conjecture is easy,
guarantee that it can be solved, prove fidelity to its informal source, or
determine a reward.

`allowlist.json` commits to every task bundle, target type, and tier. The subnet
miner accepts only those exact commitments. Within each tier:

- `selection-audit.json` records upstream status and feasibility review;
- `whole-problem-targets.json` or `subproblem-targets.json` records the exact target selection and
  stable reward-family mapping;
- `task-groups.json` records any grouped tasks (`tier-1` has none);
- `retired-source-theorems.json` prevents retired sources and canonical types
  from being selected again.

Source citations extracted from pinned Formal Conjectures docstrings are stored
in each task's metadata for site rendering.

## Rebuilding

The validator's `scripts/rebuild_task_pool.py` loads both checked-in selection audits and target policies, builds
every target in both tiers, and
inspects the result. It refuses to overwrite an existing task directory or
allowlist. Generate into fresh staging paths, review the selection and hashes,
and only then replace the published tier and pool-wide allowlist.

Production operates one active pinned pool. For a release, pause admissions and
wait until no submission is queued, running, retryable, awaiting review, or
awaiting reward processing. Then update the Formal Conjectures, Lean, Mathlib,
and verifier dependency pins together, regenerate and audit the tiers and
commitments, run the full test suite, and atomically activate the rebuilt pool
and verifier image before reopening admissions. A failed update leaves the
existing pins active. Historical pin values, task digests, tier assignments, and
reports remain in the audit database even though only one verifier version is
active.
