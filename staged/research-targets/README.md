# Staged research targets 1–30

This directory records the package-authored research targets from the `Math15` (targets 1–15) and
`Math30` (targets 16–30) libraries. They are open research statements. None is proved, and none is
part of any task tier.

`decision-matrix.json` is the reviewed decision record. The validator loads it with
`verifier.research_targets.load_research_target_decisions`, which fails closed on any malformed or
activating edit. It is not an admission input. Admitting a `research-targets` source requires all
three of these, and this release has none:

1. every global and target gate closed with cited evidence;
2. the exact theorem names in `ACTIVATED_RESEARCH_TARGETS`, through a reviewed validator commit;
3. a tier policy that names the `research-targets` family, in a reviewed tasks release.

Schema version 1 cannot express activation, so a version-1 matrix is consistent only while that
validator constant is empty.

## Decisions

| Decision | Targets | Meaning |
| --- | --- | --- |
| `hold` | 1–11, 13–15, 17, 19, 24 | Review left a target-specific gate open. |
| `excluded` | 12 | Retained as a statement; no independent reward, because the package proves 10 implies 12. |
| `source-review-accepted` | 16, 18, 20–23, 25–30 | Review left no target-specific gate. Global gates still apply. |

`source-review-accepted` is not a proof, a novelty certificate, production readiness, or
permission to activate a reward.

Targets 7, 8 and 9 form the held reward group `frankl-height-five-minimal-counterexample`. They
share a hypothetical minimal-counterexample antecedent, and one theorem could discharge several of
them. This does not make them equivalent. They stay on hold until an explicit correlated-payout
decision is recorded.

## Public-corpus screen

The version 1 catalog audit screened all 30 specifications against the OpenAI math corpus at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` (first public commit 2026-10-06 21:58:50 UTC; 722
manuscripts in 372 families). It located no direct full-statement claim for any of them. That is a
bounded correspondence screen, not proof that no solution exists, and it closes no gate. The
release owner's October 6 closures cover eleven pool targets only; they do not extend to these
specifications or to any future corpus match.

## Identities

Each target's theorem is `Math15Catalog.sourceNN` or `Math30Catalog.sourceNN` in
`FormalConjectures/ResearchTargets/Math15.lean` or `Math30.lean`. Its stable reward identity is
`fc-target:` followed by that theorem name. Task and problem IDs depend on the source commit and are
generated only on activation. `source_type_sha256` is filled from the catalog regenerated at the
validated derived source commit; it stays `null` until then.
