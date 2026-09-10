# External solution screen — September 10, 2026

Retire **Green 44 (`Green44.green_44`)**, including both proof and counterexample
tasks. The exact target already follows negatively from a public Lean theorem.
No additional active target was confirmed solved by this bounded screen.

The resulting pool has 259 targets and 518 immutable bundles: 236 Erdős targets
and 23 Green targets over 223 numbered source files. This retains the previously
released Erdős 96 reinstatement at task commit
`c47124e63e99200e48ffde0c00d4754a8cc15f2a`. That release was already pinned by
validator main, although it had not yet been merged into tasks main.

## Green 44: prior external formalization

- [Erdős Problems 1202](https://www.erdosproblems.com/1202) identifies the problem
  with Green 44 and credits a negative solution to Price and GPT-5.4 Pro.
  The indexed primary page records an April 12, 2026 edit.
- The public [Lean source](https://github.com/plby/lean-proofs/blob/1268917deaaaa0d674f651287027baa26cea9920/src/latest/ErdosProblems/Erdos1202.lean)
  contains `Erdos1202.erdos_1202_counterexample`.
  Its [first source commit](https://github.com/plby/lean-proofs/commit/3ecb1c17657a0ddb1e9b0515643021f39cc5e49a)
  is dated August 17, 2026; its public
  [proof record](https://github.com/plby/lean-proofs/blob/1268917deaaaa0d674f651287027baa26cea9920/ErdosProblems/Erdos1202.md)
  was added on August 22. Both precede the September 8 pool admission.
- The September 9 local review rebuilt the unchanged external proof and its 124
  custom dependencies in the validator's Lean 4.33.1 environment. Its exact-target
  bridge and final application passed with only `propext`, `Classical.choice`,
  and `Quot.sound`. The original declared 4.33.0 environment was not recreated.
- The bridge applies the external theorem to 1,001 primes and discards the
  smallest. The remaining primes are odd, so `(p - 1) / 2` and `p / 2` agree.
  Removing a sieve restriction preserves the counterexample; raising the prime
  bound to the tenth power yields the task's exact integer inequality.

This is a pool retirement for a prior external formalization. It makes no
authorship or copying claim and does not change any submission's review decision.

## Other matches retained after comparing the target

| Active target | Why the matched result does not settle it |
| --- | --- |
| Erdős 126, `variants.isLittleO` | The tracker marks the main lower-growth question proved. Its lower bound does not prove the separate `f(n) = o(n / log n)` upper bound in the pool. |
| Erdős 124, `ne_zero` | [The external proof](https://github.com/plby/lean-proofs/blob/main/ErdosProblems/Erdos124b.md) concerns the former statement with unrestricted digit positions. The active target requires the positive-exponent cutoff and gcd hypothesis. |
| Erdős 264, part ii | [The external results](https://github.com/plby/lean-proofs/blob/main/ErdosProblems/Erdos264.md) concern `2^n` and `2^(2^n)`. The pool asks about `n!`. |
| Erdős 354, part i | [The external file](https://github.com/plby/lean-proofs/blob/main/src/v4.24.0/ErdosProblems/Erdos354x.lean) refutes an old interleave definition using exponent `n`. The pinned target uses exponent `n / 2`. |
| Erdős 1095, both active variants | [The external proof](https://github.com/plby/lean-proofs/blob/main/ErdosProblems/Erdos1095.md) concerns a previously known bound. It does not establish the conjectured exponential lower bound or logarithmic order of growth. Upstream has renamed and strengthened `log_isTheta` to `log_equivalent`; that is not a solution to the old target. |
| Erdős 1082, part i | [The known counterexample](https://www.erdosproblems.com/1082) settles the stronger single-point question, part ii. The pool retains the total-distances question. |
| Erdős 835 | [Known results](https://www.erdosproblems.com/835) exclude many values of `k`; they leave the existential target unresolved. |
| Erdős 942 | [Known improvements](https://www.erdosproblems.com/942) concern lower bounds. They do not supply the common exponent for both bounds required by the target. |
| Green 50 | [Green's updated list](https://people.maths.ox.ac.uk/greenbj/papers/open-problems.pdf#page=25) explicitly distinguishes this Polynomial Bogolyubov question from the solved PFR problem, Green 49. |
| Green 9, parts ii and iii | The solved part i concerns three-term progressions. The active targets concern five-term integer progressions and four-term progressions over `F_5^n`. |

## Coverage and limits

The screen compared all 260 targets in the deployed task release with current
upstream source categories, the Erdős tracker, the public AI-contribution ledger,
and the `plby/lean-proofs` problem records; it also checked Green's updated list
and selected primary references. Every corresponding upstream declaration still
has category `research open`, including Green 44. The mismatch for Green 44
shows why that category alone is insufficient.

This is a dated search for confirmed resolutions, not a certification of novelty.
It does not independently rebuild every external proof, reproduce the entire
September 8 literature audit, or adjudicate disputed claims. In particular,
Erdős 96 remains admitted under the maintainer's reinstatement decision.
The upstream aliases and categories are source-level observations, not a claim
that their current types are identical to the pinned targets.

The retirement removes only Green 44's two bundles from the deployed release,
denies its theorem name and canonical type hash, and preserves its archived
display payload. All surviving bundle bytes and commitments remain unchanged.
Deployment remains a separate action; any queued paid submission for a retired
target must be accounted for before changing the production task pin.

Repository snapshots inspected:

- `tracker`: `3c68e941162f81d650fc886eed34e58bed3a6a01`
- `wiki`: `c8ad4309d20120c67cb97faa86daa1443acee018`
- `upstream`: `74b736b53ce688f57bad186b5dd862daaeeb708e`
- `lean-proofs`: `1268917deaaaa0d674f651287027baa26cea9920`
