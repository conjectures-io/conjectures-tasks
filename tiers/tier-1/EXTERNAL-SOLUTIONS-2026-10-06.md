# External solution retirements — October 6, 2026

Retire **Erdős 252 (`Erdos252.erdos_252`)**, **Erdős 701 (`Erdos701.erdos_701`)** and the single
variant **Erdős 70 (`Erdos70.erdos_70.variants.omega_times_two_four`)**, including both the proof
and the counterexample task of each. Each exact pinned target is solved in the literature or by a
public result. This file records that evidence and the exact identities retired.

The same release also closes eleven targets on the release owner's instruction
(`OWNER-ACCEPTED-CLOSURES-2026-10-06.md`) and holds five for review (`HOLDS-2026-10-06.md`). The
resulting pool has 258 targets and 516 bundles: 219 Erdős, 6 previously solved Green,
32 Wikipedia, and 1 Millennium target over 224 source files. The release ships with the
Lean 4.35.0-rc2 source repin, so every surviving bundle receives a new task ID and commitment
while keeping its stable reward identity.

## Erdős 252

The pinned statement is `answer(sorry) ↔ ∀ k ≥ 1, Irrational (erdos_252_sum k)`, where
`erdos_252_sum k = ∑' n, σ k n / n!`. The compiled target under the default answer elaboration is
`True ↔ ∀ k ≥ 1, Irrational (erdos_252_sum k)`.

Evidence supplied by the release coordinator:

- conjectures.io result `71c87792-e08f-413c-9b7a-3b61e577eed6`
  (`https://conjectures.io/results/71c87792-e08f-413c-9b7a-3b61e577eed6`);
- public Lean repository `tokengr1nder/Erdos252` at commit
  `dc071aafce41bbae41caf4c015499db6dafafd11`
  (`https://github.com/tokengr1nder/Erdos252/commit/dc071aafce41bbae41caf4c015499db6dafafd11`).

Retired identities, from the deployed tasks release `7cc9b5235000a107743dcce8fcd5f6069c34c0b6`:

| Field | Value |
| --- | --- |
| Source path | `FormalConjectures/ErdosProblems/252.lean` |
| Source type | `sha256:ddba7c9c27b5665f6cfd200e37ee4ad2f1fbe6e1312d346bce5a2e5344bdbb11` |
| Reward target | `fc-target:Erdos252.erdos_252` |
| Formalized task | `fc-6a786f99-erdos252-erdos-252-f4e9f7503d-formalized-v1` |
| Formalized bundle | `sha256:57985c599321a7affa2a9f81fcefbc7998f66058fd3381bb80b89ef5949520cc` |
| Counterexample task | `fc-6a786f99-erdos252-erdos-252-27e45e279f-counterexample-v1` |
| Counterexample bundle | `sha256:4d4d20c868f2e42e176492d34d784018ba3756638181b607ebbf5ab95c6fb723` |

## Erdős 701

The pinned statement quantifies over finite nonempty ground types only: for every lower set `F`
of subsets of a finite `X`, some `x` makes every intersecting subfamily of `F` no larger than the
star `{A ∈ F | x ∈ A}`. This is the finite hereditary-family case.

Evidence supplied by the release coordinator: arXiv:2609.19123v1 and arXiv:2609.28404v2,
Theorem 1, settle the finite hereditary-family case, with a public Lean formalization.

Retired identities, from the same deployed tasks release:

| Field | Value |
| --- | --- |
| Source path | `FormalConjectures/ErdosProblems/701.lean` |
| Source type | `sha256:ca0ae541b657e550f538d41a62a6ebd5d370b8cbde8971ccc3066b1e8ff687b8` |
| Reward target | `fc-target:Erdos701.erdos_701` |
| Formalized task | `fc-6a786f99-erdos701-erdos-701-5af5e2048d-formalized-v1` |
| Formalized bundle | `sha256:23babed48cd514be93812602fa03c3142c76b04f038faa1f1112a2d0cef3523c` |
| Counterexample task | `fc-6a786f99-erdos701-erdos-701-41f9e00a83-counterexample-v1` |
| Counterexample bundle | `sha256:fbbf02aab3c1ee1103b6401d18de498f7e45d1bb76bd404e23c1d124c0533fa1` |

## Erdős 70, the `omega_times_two_four` variant only

The pinned statement is `True ↔ OrdinalCardinalRamsey3 𝔠.ord (ω * 2) 4`: every red/blue colouring
of the triples of the well-ordered continuum ordinal has a red set of order type `ω·2` or a blue
set of size 4.

Milner and Prikry (Discrete Mathematics, 1991) prove in ZFC the stronger relation
`ω₁ → (ω·2+1, 4)³`. Restricting a colouring of `𝔠.ord` to an initial segment of order type `ω₁`,
and a red set of type `ω·2+1` to one of type `ω·2`, proves this exact variant. Jones (2000)
separates this known `ω₁` result from the still-open question for the usual order on the reals; the
pinned definition uses the well-ordered cardinal ordinal, not the real line. conjectures.io result
`81f38614-217d-4eef-aadf-d3fd9d62a8d0` already recorded a `NOT_NOVEL` decision for this variant;
it is not a paid original result.

Only this variant is retired. The general Erdős 70 question over countable ordinals, the
real-line order question, and every other Erdős 70 statement in the source are unaffected; none of
them is in this pool.

Retired identities, from the same deployed tasks release:

| Field | Value |
| --- | --- |
| Source path | `FormalConjectures/ErdosProblems/70.lean` |
| Source type | `sha256:8212d9ec59d89064b56f940bf51a9af36699a95555f245f9a8360c26a3efbd1f` |
| Reward target | `fc-target:Erdos70.erdos_70.variants.omega_times_two_four` |
| Formalized task | `fc-6a786f99-variants-omega-times-two-four-4eb41de4f8-formalized-v1` |
| Formalized bundle | `sha256:89a9664a7e355009a693117c51eaac8223b8d2004bfa49127244df10fa7c6dbb` |
| Counterexample task | `fc-6a786f99-variants-omega-times-two-four-6d316024db-counterexample-v1` |
| Counterexample bundle | `sha256:8bbf4cd56b78a6a6cf8b25fc52dfc04abe26f129846399dfda69017cff8a01bf` |

## What this retirement checked, and what it did not

The task mapping above was read from the deployed allowlist and the version 1 catalog audit, and is
rechecked mechanically by the release harness against both before any file changes. The source
statements were read from the pinned source, and each canonical type was re-exported from the
deployed source as UID 10001 and matched the published hash.

This retirement did not independently rebuild any external proof, re-derive an exact-target bridge
in the validator's environment, or review the cited papers beyond the audit. Retirement is the
conservative direction: it stops new submissions and new rewards for these targets. It makes no
authorship or copying claim and changes no review decision, payout, or attribution.

## Paid and historical work is unaffected

The 21 targets already closed on conjectures.io, among them Erdős 416(i) and the six historically
solved Green entries, remain in the selection as historical records. This retirement is separate
from them. Recorded verifications keep their original task hashes, reports, and reward identities.
The old tasks of every retired target stay readable through `retired-conjectures.json`, recovered
from the commit that deletes their bundles.

Before the task pin moves, the operator must confirm whether any queued or pending submission
targets a retiring task, and must finish any pending paid verification in the preserved previous
environment. See the release cutover instructions.
