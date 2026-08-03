# Conjectures Tasks

Versioned, immutable Lean task bundles for
[`conjectures-validator`](https://github.com/conjectures-io/conjectures-validator).

The validator materializes this repository as an ignored `tasks/` checkout pinned to an exact
commit. The active bundles are organized under readable names such as
`pool/tier-1/erdos-1094-formalized/`; each bundle contains its challenge, manifest, comparator
configuration, trusted hashes, and solution wrapper. The opaque `task_id` inside each manifest is
the stable protocol identity and intentionally does not depend on the directory name.

Published bundles are content-addressed and must not be edited in place. A changed challenge or
configuration requires a new task id and commitment. Admission policy, selection audits, and the
deny-by-default allowlist remain in the validator repository so task bytes and validator policy can
be reviewed and released together.
