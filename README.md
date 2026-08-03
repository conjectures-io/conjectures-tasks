# Conjectures Tasks

Versioned, immutable Lean task bundles for
[`conjectures-validator`](https://github.com/conjectures-io/conjectures-validator).

The validator includes this repository as its `tasks/` submodule and pins an exact commit. The
active bundles are organized under readable names below `pool/tier-1/` and `pool/tier-2/`; each
bundle contains its challenge, manifest, comparator
configuration, trusted hashes, and solution wrapper. The opaque `task_id` inside each manifest is
the stable protocol identity and intentionally does not depend on the directory name.

The current snapshot contains 148 bundles: proof/refutation pairs for 29 complete tier-1 targets
and 45 audited tier-2 parts or variants.

Published bundles are content-addressed and must not be edited in place. A changed challenge or
configuration requires a new task id and commitment. Admission policy, selection audits, and the
deny-by-default allowlist remain in the validator repository so task bytes and validator policy can
be reviewed and released together.
