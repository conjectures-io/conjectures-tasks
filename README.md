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

The current snapshot contains one tier with 272 bundles: proof/refutation pairs for 136 audited
direct propositions (118 Erdős targets and 18 Green's Open Problems targets). The tier label is
retained for compatibility and does not rank or classify the targets.

Published bundles are content-addressed and must not be edited in place. A changed challenge or
configuration requires a new task id and commitment. The deny-by-default allowlist, tier policy,
and selection audits live beside the bundles in this repository; see
[`POOL.md`](POOL.md). The validator pins one exact tasks commit and consumes that release as a unit.

Task selection, bundle generation, pool rebuilding, and fixture generation are owned here under
`scripts/`. Those tools find a sibling `conjectures-validator` checkout by default; set
`CONJECTURES_VALIDATOR_ROOT` when using a different layout.
