# Owner-accepted publication closures — October 6, 2026

On 2026-10-06 at 23:17:23 UTC the release owner instructed, for the eleven targets below: “Assume
the proofs are valid and close them.” Each target was matched by the version 1 catalog audit to a
resolution claim in the public OpenAI math corpus at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` (first public commit 2026-10-06 21:58:50 UTC), and the
audit had held it for validation. Both the proof and the counterexample task of each target leave
the pool with reason `OWNER_ACCEPTED_PUBLICATION_CLOSURE`.

## What this is, and what it is not

This is owner-directed acceptance of a publication claim. **No independent proof replay,
exact-target bridge, Lean rebuild, or certification was performed** by the audit or by this
release, and none is implied. The corpus itself states that its results are at differing stages of
verification. A closure stops new submissions and new rewards for the exact target; it makes no
authorship, priority, or copying claim and changes no review decision, payout, or attribution.

The closure covers exactly these eleven reward targets. It does not accept any other manuscript of
the corpus's 722, any other target in the same families, or any future match. Erdős 416(i), which
the corpus also addresses, stays closed on conjectures.io with its existing credit. Internal
manuscript dates are not public disclosure dates; the corpus's public chronology starts at its first
public commit above.

The owner's decision record, with the audit record of each target (statement, types, task
commitments, corpus families, scope explanation, and stated verification limits), is published
byte-for-byte as `owner-accepted-corpus-closures-2026-10-06.json` beside this file.

## Closed targets

All identities are from the deployed tasks release `7cc9b5235000a107743dcce8fcd5f6069c34c0b6` at
source `6a786f997e18e8f095762a2830d191b7e25e505e`. “Relationship” is the audit's classification
of the corpus claim against the exact pinned target.

| Target | Family | Relationship | Source type |
| --- | --- | --- | --- |
| `Erdos3.erdos_3` | 159 | exact full claim | `sha256:522de161b4ee6af784bc8512ea12aa5fcc0267962999817271d2aed6462a034b` |
| `Erdos138.erdos_138` | 160 | stronger implication | `sha256:371edd26df33585f57ad32c7a16f6caa582021d5c69e89a558e516130ad1a3b7` |
| `Erdos142.erdos_142.variants.lower` | 159 | stronger implication | `sha256:a3f73a02f0e943bd284c080928f5a62067c273a79ce4fb3b55dd05a781c9f52c` |
| `Erdos172.erdos_172` | 164 | exact full claim | `sha256:1ffef2913a9676ad280a9357549d65ab3c218c5b18ca3c03c98bb86674454892` |
| `Erdos184.erdos_184` | 181 | exact full claim | `sha256:d2c466b8ecc3b01fe0ae65247bcd3d44d4c2063c277ee263d75c4ac63ea17c2c` |
| `Erdos304.upper_bound` | 025 | stronger implication | `sha256:1f68abefc6f19036f8af8e734ce9ddf0abe19c554cb3f8d9571d9ab3d0c868fa` |
| `Erdos371.erdos_371` | 012 | exact full claim | `sha256:852d783431a440ea8fc1fc6f6a232d9e5ce0b67037bf3f2393ec2d0563c6af71` |
| `Erdos821.erdos_821` | 011 | exact full claim | `sha256:1e884dc69d11c49e29517988c58442de08c49969278cb26ca8185f60ab5d6bad` |
| `Erdos952.erdos_952` | 028 | stronger implication (refutation) | `sha256:19699b5a3a278bd801a00d0c8695afb7ccde0c07cac479aff1404d60c26564f8` |
| `Erdos978.erdos_978.parts.ii` | 020 | stronger implication | `sha256:47372f3c4a860aeb771ecd24ae367c03e80de09cf951d3f94fd6a78370d54787` |
| `Erdos978.erdos_978.parts.iii` | 020 | stronger implication | `sha256:3e683925ba54f309a76278d99386826c87b151bb5cb1df828d0e3643f0e240fa` |

Closed tasks:

| Target | Formalized task | Counterexample task |
| --- | --- | --- |
| `Erdos3.erdos_3` | `fc-6a786f99-erdos3-erdos-3-3dc5c7ba93-formalized-v1` | `fc-6a786f99-erdos3-erdos-3-1b23a76e79-counterexample-v1` |
| `Erdos138.erdos_138` | `fc-6a786f99-erdos138-erdos-138-1ef589ced9-formalized-v1` | `fc-6a786f99-erdos138-erdos-138-0f57cb3ce1-counterexample-v1` |
| `Erdos142.erdos_142.variants.lower` | `fc-6a786f99-variants-lower-a1e26136f9-formalized-v1` | `fc-6a786f99-variants-lower-8a06da4606-counterexample-v1` |
| `Erdos172.erdos_172` | `fc-6a786f99-erdos172-erdos-172-6b0bfa5619-formalized-v1` | `fc-6a786f99-erdos172-erdos-172-c7edf48af7-counterexample-v1` |
| `Erdos184.erdos_184` | `fc-6a786f99-erdos184-erdos-184-3e34e17a72-formalized-v1` | `fc-6a786f99-erdos184-erdos-184-47eadac979-counterexample-v1` |
| `Erdos304.upper_bound` | `fc-6a786f99-erdos304-upper-bound-69d8d8c839-formalized-v1` | `fc-6a786f99-erdos304-upper-bound-8ccf89d842-counterexample-v1` |
| `Erdos371.erdos_371` | `fc-6a786f99-erdos371-erdos-371-6bced2329f-formalized-v1` | `fc-6a786f99-erdos371-erdos-371-9a3982ee28-counterexample-v1` |
| `Erdos821.erdos_821` | `fc-6a786f99-erdos821-erdos-821-d2899b72e2-formalized-v1` | `fc-6a786f99-erdos821-erdos-821-c2f5a259f8-counterexample-v1` |
| `Erdos952.erdos_952` | `fc-6a786f99-erdos952-erdos-952-6a92117272-formalized-v1` | `fc-6a786f99-erdos952-erdos-952-e18234649c-counterexample-v1` |
| `Erdos978.erdos_978.parts.ii` | `fc-6a786f99-parts-ii-0993545a2c-formalized-v1` | `fc-6a786f99-parts-ii-8367de682c-counterexample-v1` |
| `Erdos978.erdos_978.parts.iii` | `fc-6a786f99-parts-iii-027c8cd53a-formalized-v1` | `fc-6a786f99-parts-iii-fade2a2a3d-counterexample-v1` |

The release harness rechecks every row above against the deployed allowlist, the audit, and the
owner's decision record before any file changes. Bundle digests and target types are in the JSON
record.

## History is unaffected

Prior paid closures, historical attributions, and every recorded verification keep their original
task hashes, reports, and reward identities. The old tasks of these targets stay readable through
`retired-conjectures.json`. Any pending submission is finished in its preserved original
environment before the task pin moves; see the release cutover instructions.
