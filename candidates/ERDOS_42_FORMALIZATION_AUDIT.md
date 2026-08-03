# Erdős 42-candidate formalization audit

Audit date: `2026-08-03`

Formal Conjectures commit: `f7349f32ba6df6e7b7baf77467a3c6c7777a634d`

Erdős Problems database commit: `2e7e7a630f9814f3df562bc1b207d9ad41451a55`

Lean toolchain: `leanprover/lean4:v4.27.0`

Mathlib commit: `a3a10db0e9d66acbebf76c5e6a135066525ac900`

## Result

The direct-candidate inventory contains 68 declarations from 42 numbered Erdős problem sources.
All 42 source files elaborate successfully with the pinned Lean and Mathlib versions. Compilation
does not establish that a declaration faithfully expresses its cited mathematical statement.

The semantic audit gives the following results:

| Unit | Pass | Hold | Correction required | Total |
|---|---:|---:|---:|---:|
| Numbered source files | 28 | 6 | 8 | 42 |
| Candidate declarations | 41 | 15 | 12 | 68 |

`Pass` means the candidate proposition and its supporting definitions faithfully express the cited
part or variant, subject to the normal limitations of an informal-to-formal review. `Hold` means the
formal type is coherent but an authority, scope, or provenance question prevents admission.
`Correction required` means the current type is mismatched, already known, contradicted by a current
result, or promotes a conditional/question into an unsupported unconditional proposition.

None of the 41 passing declarations becomes a whole numbered Erdős problem merely by passing this
audit. They remain named parts, variants, or derived targets. The existing one-number/one-whole-
problem reward policy therefore still cannot describe them as 41 additional whole Erdős problems.

## Remediation

The correction set is captured in
[`formal-conjectures-erdos-audit-fixes.patch`](formal-conjectures-erdos-audit-fixes.patch). All nine
affected Erdős source files and the adjusted subset index elaborate with the pinned toolchain after
applying it. The patch:

- repairs the Erdős 137 interval endpoint and the Erdős 477 integer domain;
- restores the cited implication direction in Erdős 329 and marks the known implication solved;
- marks the Hegyvári and Erdős 1095 upper bounds solved;
- replaces ratio convergence by `IsTheta` for the Erdős 1095 `asymp` claim;
- converts both Erdős 1101 questions to proposition-answer wrappers;
- restores the Dickson-conjecture hypothesis in the Erdős 891 consequence and marks it solved;
- records the negations of the two contradicted Erdős 539 targets as solved; and
- corrects the misleading `add_one` theorem name for the `8p^2 - 1` variant of Erdős 913.

After those fixes, excluding unresolved corrections and all holds leaves
[`ERDOS_DIRECT_CANDIDATES_CLEAN.md`](ERDOS_DIRECT_CANDIDATES_CLEAN.md): **45 open direct
propositions across 33 numbered sources**. This post-fix count does not change the original audit
totals above, which describe the input snapshot.

## Method

For every source, this audit checked:

- the exact candidate theorem type and all problem-specific definitions it uses;
- quantifier order, domains, interval endpoints, coercions, asymptotic relations, and polarity;
- the theorem docstring against the official Erdős Problems page as viewed on `2026-08-03`;
- the pinned tracker status and candidate inventory flags;
- open pull requests recorded by the candidate snapshot; and
- elaboration of the complete source file with the pinned toolchain.

The review is an admission screen, not a proof that the informal conjecture is true or that the Lean
definitions are mathematically equivalent in every foundational presentation.

## Row-level decisions

The theorem names below omit their leading `ErdosN.erdos_N` where that makes the table easier to
read. Every row covers all direct candidates from that numbered source.

| Problem | Candidate declarations | Result | Review |
|---:|---|---|---|
| [10](https://www.erdosproblems.com/10) | `variants.grechuk` | Pass | The set-of-sums definition allows at most three powers of two and the target exactly states infinitude of the even exceptions described on the source page. Including zero in the ambient natural-number set does not affect infinitude. |
| [11](https://www.erdosproblems.com/11) | `variants.not_four_dvd`; `variants.two_pow_two` | Hold | The current source page asks about sufficiently large odd integers, while both Lean variants quantify over every admissible `n > 1`. The stronger all-`n` scope needs a primary-source citation or an eventual quantifier. |
| [126](https://www.erdosproblems.com/126) | `variants.isLittleO` | Pass | `IsMaximalAddFactorsCard` captures the minimum distinct-prime-factor count over all `n`-element sets. Ordered off-diagonal pairs square repeated factors but do not change the set of distinct prime factors. |
| [137](https://www.erdosproblems.com/137) | `variants.multiple_powerful_factors` | Correction required | The cited product is `m(m+1)\cdots(m+n)`, but `Finset.Ioc m (m+n)` formalizes `(m+1)\cdots(m+n)`. Use the inclusive interval or document and prove an exact reindexing equivalence. |
| [142](https://www.erdosproblems.com/142) | `variants.lower` | Pass | The target is the stated `r_k(N) = o_k(N / log N)` bound. The extra harmless `k = 2` case does not weaken the intended fixed-`k` statement. |
| [143](https://www.erdosproblems.com/143) | `parts.ii` | Pass | `WellSeparatedSet` includes the domain, infinitude, countability, and separation hypotheses; summability over the subtype `A` expresses the cited series. |
| [208](https://www.erdosproblems.com/208) | `variants.log_bound` | Pass | The squarefree-number enumeration and big-O target match Erdős's suggested logarithmic gap bound. The zero-based indexing shift is asymptotically immaterial. |
| [218](https://www.erdosproblems.com/218) | `variants.le`; `variants.ge`; `variants.infinite_equal_prime_gap` | Pass | The two density orientations and the equal-consecutive-gap infinitude statement match the three claims on the source page. |
| [241](https://www.erdosproblems.com/241) | `variants.generalization` | Pass | Multisets correctly quotient the trivial permutations of an `r`-fold sum, and the target uses asymptotic equivalence with `N^(1/r)`. |
| [242](https://www.erdosproblems.com/242) | `variants.schinzel_generalization` | Pass | Fixed positive `a`, eventual `n`, distinct positive denominators, and rational equality match Schinzel's generalization. |
| [272](https://www.erdosproblems.com/272) | `variants.szabo_strong` | Pass | The target `N^2/2 + O(N)` is equivalent to the source's `binom(N,2) + O(N)`. Intersections are required to be nonempty arithmetic progressions. |
| [313](https://www.erdosproblems.com/313) | `variants.primary_pseudoperfect_are_infinite` | Pass | The projected denominators are exactly the primary pseudoperfect numbers; the source notes that at most one prime set occurs for each denominator. |
| [324](https://www.erdosproblems.com/324) | `variants.quintic` | Pass | Injectivity on pairs `a < b` of nonnegative integers exactly expresses the proposed `x^5` Sidon property. |
| [329](https://www.erdosproblems.com/329) | `variants.converse_implication` | Correction required | The source says the embedding property would imply maximum density `1`; the candidate reverses this implication. Its consequent is already known false, making the target an artificial reformulation of “maximum density is not 1,” not the cited Erdős variant. |
| [340](https://www.erdosproblems.com/340) | `variants.sub_hasPosDensity` | Pass | Natural-number pointwise subtraction gives the nonnegative part of `A-A` plus zero; adding zero does not affect positive natural density. A formalization note should make this convention explicit. |
| [349](https://www.erdosproblems.com/349) | `complete_for_alpha_in_Ioo_one_to_goldenRatio` | Hold | The proposition matches the stated golden-ratio strip, but the snapshot records several active PRs proving and changing nearby positive ranges. Rebase, recompile, and redo the collision/status review after those PRs settle. |
| [357](https://www.erdosproblems.com/357) | `parts.i`; `variants.hegyvari`; `variants.infinite_set_density`; `variants.infinite_set_sum`; `variants.monotone.parts.i` | Mixed: four pass, one correction | The main little-o target and the three infinite/weakly-monotone variants match the page. `variants.hegyvari` is explicitly a theorem proved by Hegyvári, so its `research open` category is wrong and it is not a reward candidate. |
| [359](https://www.erdosproblems.com/359) | `parts.i`; `parts.ii`; `variants.isGoodFor_1_asymptotic` | Pass | The least-missing-consecutive-sum recursion and the two growth limits match the main question; the asymptotic variant matches Andrews's conjecture. |
| [364](https://www.erdosproblems.com/364) | `variants.strong` | Pass | The target states the cited positive-power separation between every second powerful number. |
| [373](https://www.erdosproblems.com/373) | `variants.maximal_solution`; `variants.suranyi` | Pass | The list model enforces decreasing factors at least two and excludes the trivial `n-1` factor. The maximal-`n` and two-factor uniqueness targets match the cited conjectures. |
| [406](https://www.erdosproblems.com/406) | `variants.one_two` | Pass | `IsGreatest` expresses that `2^15` belongs to, and is the largest member of, the powers of two whose ternary digits are only `1` and `2`. |
| [409](https://www.erdosproblems.com/409) | `variants.sigma_termination` | Pass | The divisor-sum iteration and prime-termination target match the analogous open question on the source page. |
| [416](https://www.erdosproblems.com/416) | `parts.i` | Pass | `V` counts distinct attained totients up to `x`, and the real ratio limit is exactly `V(2x)/V(x) -> 2`. |
| [477](https://www.erdosproblems.com/477) | `variants.X_pow_three`; `variants.monomial` | Correction required | The source quantifies over the value set `{f(n) : n in Z}`, but every Lean target uses only `f(n)` for positive integers. This is a material domain change, especially for odd-degree polynomials. |
| [535](https://www.erdosproblems.com/535) | `variants.first_open_case`; `variants.sunflower_strong` | Mixed: one pass, one hold | The `r = 3` upper bound is faithful. The stronger `Omega(n)=k` sunflower target is not stated on the current source page, which instead mentions the ordinary sunflower implication; verify the exact auxiliary statement against the cited primary papers before admission. |
| [539](https://www.erdosproblems.com/539) | `variants.sq`; `variants.isBigO_sq`; `variants.sq_cube_root`; `variants.sq_cube_root_isBigO` | Mixed: two hold, two corrections | The square-root targets are plausible derived endpoint questions but are not stated as conjectures by the source, so hold them for provenance review. The current source page reports `h(n) <= exp(O(sqrt(log n))) n^(1/2)` and hence `h(n)=n^(1/2+o(1))`; this rules out both `Theta(n^(2/3))` and `n^(2/3)=O(h(n))`. |
| [770](https://www.erdosproblems.com/770) | `variants.three` | Pass | The gcd-one definition is the collective-coprimality convention consistent with the page's stated `h(n)=n+1` characterization, and the target exactly states infinitely many values equal to three. |
| [789](https://www.erdosproblems.com/789) | `variants.sq`; `variants.sq_isBigO`; `variants.cube_root_linearithmic`; `variants.isBigO_cube_root_linearithmic` | Hold | The source asks only to estimate `h(n)` and records lower and upper bounds. These four declarations promote the two endpoints into alternative conjectural equalities or missing one-sided bounds without a cited conjecture. They are coherent research prompts, but not yet source-backed Erdős targets. |
| [853](https://www.erdosproblems.com/853) | `parts.i`; `parts.ii` | Pass | The minimum missing even prime gap and both divergence assertions match the two questions; requiring even `t` is the necessary correction recorded on the page. |
| [887](https://www.erdosproblems.com/887) | `parts.ii` | Pass | The floor/ceiling open interval selects exactly the integer divisors in the stated real interval, and `K` is absolute while the sufficiently-large threshold may depend on `C`. |
| [889](https://www.erdosproblems.com/889) | `variants.general` | Pass | The prime-factor filter is equivalent to selecting prime factors greater than `k`, and the supremum over `k >= l` matches the fixed-`l` generalization. |
| [891](https://www.erdosproblems.com/891) | `variants.weisenberg` | Correction required | The cited source records the conclusion only as a consequence of Dickson's conjecture. The Lean declaration drops that hypothesis and promotes the consequence to an unconditional open theorem. Either formalize the conditional implication or cite an independent conjecture of the conclusion. |
| [912](https://www.erdosproblems.com/912) | `variants.tao` | Pass | The factorization range counts distinct exponent values, and the asymptotic constant `sqrt(2*pi)` matches the cited heuristic. |
| [913](https://www.erdosproblems.com/913) | `variants.infinite_many_8p_sq_add_one_primes` | Pass | The proposition correctly uses `8*p^2 - 1` and matches the source. The theorem's `add_one` name is a naming error only and should be fixed before publication. |
| [931](https://www.erdosproblems.com/931) | `variants.exists_prime` | Hold | This variant is absent from the current source page and has no primary citation in the file. “Between” is also formalized inclusively as `n1 <= p <= n2`. Add provenance and resolve strict versus inclusive endpoints before admission. |
| [1055](https://www.erdosproblems.com/1055) | `variants.erdos_limit`; `variants.selfridge_limit` | Pass | `p(r)` is the least prime in the recursively defined class, and the divergent versus bounded alternatives match the conjectures attributed to Erdős and Selfridge. |
| [1060](https://www.erdosproblems.com/1060) | `parts.ii` | Pass | The count of solutions to `k*sigma(k)=n` and the polylogarithmic big-O bound match the second question. Allowing a real exponent `C` is harmless, although `C > 0` would document the intended reading more clearly. |
| [1074](https://www.erdosproblems.com/1074) | `variants.EHSNumbers_one_half` | Pass | The EHS set and natural-density value `1/2` match the explicit Hardy-Subbarao heuristic quoted by the source. |
| [1093](https://www.erdosproblems.com/1093) | `parts.ii` | Pass | The target includes `n >= 2k`, the smooth-number deficiency, and the condition excluding binomial coefficients divisible by primes at most `k`; finiteness then matches the second question. |
| [1095](https://www.erdosproblems.com/1095) | `variants.upper_conjecture`; `variants.lower_conjecture`; `variants.log_equivalent` | Mixed: one pass, two corrections | The lower conjecture is faithful. The source page says the exponential upper bound was proved, not conjectured, so it is miscategorized. The heuristic uses `asymp` (two-sided constant bounds), while `IsEquivalent` formalizes ratio tending to one; use `IsTheta` unless a stronger primary source is supplied. |
| [1101](https://www.erdosproblems.com/1101) | `parts.i`; `parts.ii` | Correction required | The source asks whether polynomial-growth and subexponential-growth good sequences exist. The Lean declarations hard-code “no” for the first and “yes” for the second without a cited conjectural polarity. These should be proposition-answer wrappers or carry primary evidence for the chosen answers. |
| [1167](https://www.erdosproblems.com/1167) | `variants.finite_targets`; `variants.binary_colors`; `variants.infinite_targets`; `variants.r_eq_two` | Hold | The current web statement omits conditions that the source file says occur in the original list; the repaired Lean theorem adds `gamma >= 2` but still omits the recorded `kappa_alpha > r` condition. The four candidates are coherent derived special cases, not separately sourced numbered problems. Resolve the authoritative statement and scope before admission. |

## Required follow-up

Before building any new task bundles:

1. Land the checked correction patch in Formal Conjectures and pin the resulting commit.
2. Keep the solved, disproved, conditional-result, and answer-wrapper declarations out of the direct lane.
3. Resolve the 15 held declarations with primary-source or upstream-PR evidence.
4. Refresh the candidate inventory at the eventual release commit and rerun target collision checks.
5. Decide explicitly whether named parts and variants receive independent reward identities; this audit
   does not relax the existing whole-problem policy.
