# Corrected Erdős direct-candidate list

Audit date: `2026-08-03`

Formal Conjectures base commit: `f7349f32ba6df6e7b7baf77467a3c6c7777a634d`

Patched release commit: `379fc0298dc146df549e7061c3ede0353a5bb51f`

This is the source-faithful replacement for the 68-declaration provisional Erdős inventory. It
contains **45 open direct propositions from 33 numbered source files**: the 41 declarations that
passed the semantic audit plus four declarations repaired by the accompanying source patch.

These are the 45 additions to the single-tier release. Every entry is a named part or variant
rather than a complete numbered problem. Each receives its own proof/refutation task pair and commit-specific
`problem_id`, but all targets under the same Erdős number share a stable `reward_family_id`.

The declaration names below omit the `ErdosN.erdos_N.` prefix.

## Clean candidates

| Problem | Open direct declarations | Count | Status |
|---:|---|---:|---|
| 10 | `variants.grechuk` | 1 | Audited |
| 126 | `variants.isLittleO` | 1 | Audited |
| 137 | `variants.multiple_powerful_factors` | 1 | Fixed: product now includes `m` via `Finset.Icc` |
| 142 | `variants.lower` | 1 | Audited |
| 143 | `parts.ii` | 1 | Audited |
| 208 | `variants.log_bound` | 1 | Audited |
| 218 | `variants.le`; `variants.ge`; `variants.infinite_equal_prime_gap` | 3 | Audited |
| 241 | `variants.generalization` | 1 | Audited |
| 242 | `variants.schinzel_generalization` | 1 | Audited |
| 272 | `variants.szabo_strong` | 1 | Audited |
| 313 | `variants.primary_pseudoperfect_are_infinite` | 1 | Audited |
| 324 | `variants.quintic` | 1 | Audited |
| 340 | `variants.sub_hasPosDensity` | 1 | Audited |
| 357 | `parts.i`; `variants.infinite_set_density`; `variants.infinite_set_sum`; `variants.monotone.parts.i` | 4 | Audited; proved Hegyvári bound excluded |
| 359 | `parts.i`; `parts.ii`; `variants.isGoodFor_1_asymptotic` | 3 | Audited |
| 364 | `variants.strong` | 1 | Audited |
| 373 | `variants.maximal_solution`; `variants.suranyi` | 2 | Audited |
| 406 | `variants.one_two` | 1 | Audited |
| 409 | `variants.sigma_termination` | 1 | Audited |
| 416 | `parts.i` | 1 | Audited |
| 477 | `variants.X_pow_three`; `variants.monomial` | 2 | Fixed: value set now ranges over all `ℤ` |
| 535 | `variants.first_open_case` | 1 | Audited |
| 770 | `variants.three` | 1 | Audited |
| 853 | `parts.i`; `parts.ii` | 2 | Audited |
| 887 | `parts.ii` | 1 | Audited |
| 889 | `variants.general` | 1 | Audited |
| 912 | `variants.tao` | 1 | Audited |
| 913 | `variants.infinite_many_8p_sq_sub_one_primes` | 1 | Audited; misleading `add_one` name corrected |
| 1055 | `variants.erdos_limit`; `variants.selfridge_limit` | 2 | Audited |
| 1060 | `parts.ii` | 1 | Audited |
| 1074 | `variants.EHSNumbers_one_half` | 1 | Audited |
| 1093 | `parts.ii` | 1 | Audited |
| 1095 | `variants.lower_conjecture`; `variants.log_isTheta` | 2 | Audited; `asymp` corrected to `IsTheta` |
| **Total** |  | **45** | **33 numbered sources** |

## Removed from the direct list

| Disposition | Declarations | Reason |
|---|---|---|
| Solved | 329 `variants.converse_implication`; 357 `variants.hegyvari`; 891 `variants.weisenberg`; 1095 `variants.upper_conjecture` | The patch restores the cited implication direction and Dickson hypothesis where needed; all four are known results rather than open direct targets. |
| Disproved | 539 `variants.sq_cube_root`; 539 `variants.sq_cube_root_isBigO` | The newer `h(n)=n^(1/2+o(1))` result contradicts both positive targets; the patch records their negations as solved. |
| Answer wrappers | 1101 `parts.i`; 1101 `parts.ii` | The source asks questions and supplies no justified polarity. The corrected types use `answer(sorry) ↔ P`, which is outside the direct-proposition lane. |
| Held | 11 (2); 349 (1); 535 (1); 539 (2); 789 (4); 931 (1); 1167 (4) | Fifteen declarations still need provenance, status, endpoint, or authoritative-statement resolution. |

## Release disposition

The source patch is applied at the pinned derived commit, the catalog has been regenerated, and all
45 targets passed the direct-proposition and collision gates. They are admitted into the same tier
as the existing 29 targets without creating duplicate rewards: variants and parts share the
numbered problem's stable reward family, including the seven overlapping families.
