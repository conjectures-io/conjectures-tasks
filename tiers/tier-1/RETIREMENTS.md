# Source theorem retirements

- `Erdos1055.erdos_1055.variants.erdos_limit` — 2026-08-05 — `TYPE_DEPENDS_ON_SORRY (Erdos1055.p := Nat.find (exists_p r), exists_p is sorried)`
- `Erdos1055.erdos_1055.variants.selfridge_limit` — 2026-08-05 — `TYPE_DEPENDS_ON_SORRY (Erdos1055.p := Nat.find (exists_p r), exists_p is sorried)`
- `Erdos1093.erdos_1093.parts.ii` — 2026-08-05 — `SOURCE_MISMATCH (Nat.smoothNumbers k means primes < k; erdosproblems.com/1093 defines k-smooth as primes ≤ k)`
- `Erdos15.erdos_15` — 2026-08-05 — `SOURCE_MISMATCH + EXPLOITABLE (the informal problem asks for real convergence; Lean states Summable over ℚ, so failure of ℚ-summability does not establish real divergence; the counterexample exploited this domain mismatch)`
- `Green54.green_54` — 2026-08-05 — `SOURCE_MISMATCH (Green #54 is per-n on ℝ^n; formalization is a single statement on ℕ → ℝ with Measure.infinitePi gaussian — nonequivalent setting)`
- `Green77.green_77` — 2026-08-05 — `SOURCE_MISMATCH + EXPLOITABLE (Erdos507.minTriangleArea infimum ranges over Affine.Triangle = affinely independent only; collinear-heavy configs give α(n) ≳ 1/n, refuting the formalized n^(−2+o(1)) claim by elementary geometry)`
