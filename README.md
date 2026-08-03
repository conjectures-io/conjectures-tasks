# Conjectures Tasks

Versioned, immutable Lean task bundles for
[`conjectures-validator`](https://github.com/conjectures-io/conjectures-validator).

The validator includes this repository as its `tasks/` submodule and pins an exact commit. The
active bundles are organized as `pool/<tier>/<task_id>/`; each bundle contains its challenge,
manifest, comparator configuration, trusted hashes, and solution wrapper.

Published bundles are content-addressed and must not be edited in place. A changed challenge or
configuration requires a new task id and commitment. Admission policy, selection audits, and the
deny-by-default allowlist remain in the validator repository so task bytes and validator policy can
be reviewed and released together.
