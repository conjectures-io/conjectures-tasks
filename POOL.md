# Task pool

The checked-in task pool is a deny-by-default set of exact Formal Conjectures
proof and counterexample targets for the production verifier and subnet submission protocol. Tasks
retain a tier field for release compatibility. The current pool has one tier, and that label does
not rank, price, or otherwise distinguish targets.

## Layout

- `allowlist.json` is the pool-wide, machine-readable admission set.
- `tiers/<tier>/` contains that tier's selection audit, policy inputs, and pinned source corrections.
- [`pool/<tier>/`](https://github.com/conjectures-io/conjectures-tasks/tree/main/pool)
  contains the immutable task bundles in this repository.

The current release places all 146 audited targets in `tier-1`: 124 Erdős targets and 22 Green's
Open Problems targets, including both complete numbered statements and independently meaningful
parts or variants. Additional tiers may be introduced later, but no tier distinction is active now.

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
- satisfy the common selection and freshness rules;
- have no cataloged non-admitted proof collision for either `P` or `¬ P`;
- compile and pass the independent `TaskInspector` target check.

Each task contains one exact canonical theorem. The pool includes complete statements and the 62
named parts or variants that passed the semantic audit under the same tier policy. Answer wrappers
and multi-target bundles remain excluded.

The shared selection has a solver-oriented audit. Every source:

- belongs to an explicitly approved source family with a canonical numbered source path;
- is still marked `research open` on the reviewed upstream `main`;
- has its source-family open status recorded against the pinned Erdős Problems database or
  Ben Green's Open Problems document;
- has no open upstream pull request resolving or correcting the selected theorem
  at audit time; unrelated source-file changes are recorded;
- has no formal-proof metadata or cataloged proved-type collision;
- has at least one recorded feasibility signal: a compact target, discrete
  domain, finite or finitary structure, partial results in the same source, or a
  standard Mathlib surface.

The machine-checked source identity includes `source_family`, `source_problem_number`, the
canonical source path, and the theorem namespace. The status source is pinned per family, so an
Erdős tracker status cannot be used to admit a Green target (or vice versa).

No Formal Conjectures source family is excluded at the pool level. In particular,
Written on the Wall II conjectures may be included in a future release after the same open-status,
pull-request, collision, and compiled-target checks.

The pool creates one `formalized`/`counterexample` pair for every admitted theorem.
Both bundles have distinct task IDs and commitments but share one deterministic, source-pinned
`problem_id`. They also carry a stable `reward_target_id` derived from the exact theorem name.
The reward store enforces at most one reward for that theorem target across its proof/refutation
pair and later source repins. Parent statements, parts, and variants are independent targets with
independent rewards.
The pool does not extract propositions from answer wrappers or substitute answers.

A counterexample task asks for a kernel-checked proof of `¬ P`. For a universal
conjecture this can normally exhibit a concrete violating witness. For other
logical shapes it is more accurately a refutation and need not expose a
machine-readable witness.

## Scope

`tier-1` contains all 292 task bundles covering 146 audited targets: 124 Erdős targets and 22
Green's Open Problems targets. Every bundle has exactly one theorem target and every theorem target
has its own stable reward identity.

The GitHub review covered all 297 open pull requests visible at audit time and
excluded selected theorems with an active resolution or correction. A separate
pinned check against the Erdős Problems database excludes Erdős parent problems
recorded as solved. The Green targets are checked against the December 2025 update
of Ben Green's Open Problems document and a dated literature/preprint screen.

For the 22 Green targets added in the 2026-08-05 audit, the source references,
the Green document, and exact/problem-number literature and preprint searches
disclosed no published solution. This is a dated negative-result screen, not proof
that no obscure or unpublished argument exists.

“Plausibly attackable” is a comparative solver-target screen, not a promise.
These checks establish that a task is well-formed, remained upstream-open at the
audit boundary, avoided a known active proof or correction PR, and has a
manageable formal surface. They do not establish that the conjecture is easy,
guarantee that it can be solved, prove fidelity to its informal source, or
determine a reward.

`allowlist.json` commits to every task bundle, target type, and tier. The subnet miner accepts only
those exact commitments. For the single active tier:

- `selection-audit.json` records upstream status and feasibility review;
- `task-targets.json` records the exact target selection and stable per-target reward identity;
- `task-groups.json` records any grouped tasks (`tier-1` has none);
- `retired-source-theorems.json` prevents retired sources and canonical types
  from being selected again.

Source citations extracted from pinned Formal Conjectures docstrings are stored
in each task's metadata for site rendering.

## Rebuilding

This repository's `scripts/rebuild_task_pool.py` loads the checked-in selection audit and target
policy, uses the separately checked-out validator implementation to build every target in the
active tier, and
inspects the result. It refuses to overwrite an existing task directory or
allowlist. Generate into fresh staging paths, review the selection and hashes,
and only then replace the published tier and pool-wide allowlist.

Production operates one active pinned pool. For a release, pause admissions and
wait until no submission is queued, running, retryable, awaiting review, or
awaiting reward processing. Then update the Formal Conjectures, Lean, Mathlib,
and verifier dependency pins together, regenerate and audit the tier and
commitments, run the full test suite, and atomically activate the rebuilt pool
and verifier image before reopening admissions. A failed update leaves the
existing pins active. Historical pin values, task digests, tier assignments, and
reports remain in the audit database even though only one verifier version is
active.
