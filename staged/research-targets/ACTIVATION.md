# Research-target activation

Release status: **proposed-pending-owner-approval**. The owner has not yet approved this activation; until a recorded approval closes the approval gates in `decision-matrix.json`, this tasks release is a proposal.

Activation admits a package-authored statement as a reward target. It is not a proof, a refutation, a novelty certificate, or a claim that the statement is true. Every target below is open as far as the dated screens recorded in `decision-matrix.json` found.

## Admitted targets

| Target | Theorem | Source type | Description |
| --- | --- | --- | --- |
| 4 | `Math15Catalog.source04` | `sha256:fc9ddfec4d0d1725aa3a0a9d06329d3accbe40fc8bfcfa6480ddf9d8ba13ae22` | Package-authored Lean formalization of the converse that arXiv:2608.13599v2 proposes in section 9 (the paragraph after Question 9.1): for both-large removals, a tight two-swap speed set must satisfy the replacement conditions of Theorem 5.1, with inserted speeds at least n and the gcd interval condition (4). The formalization states it for either matching of the two replacements. It is an open proposal of that paper, not one of its theorems. |
| 5 | `Math15Catalog.source05` | `sha256:3055fcc5b70670e196527bd0995238dc36a4ce8a04b13b1ebec519f5c0fc258a` | Package-authored Lean formalization of the four-speed case that Fan and Sun leave open (arXiv:2306.10417v2, Conjecture 1.3 and section 6.2(1)): for a primitive set of four speeds whose pairwise gcds are at most 2, the maximum loneliness is at least 1/4 or equals s/(4s + k) for some 1 <= k <= 4 with k <= s. The condition k <= s follows from the known four-speed bound ML >= 1/5 by a kernel-checked numeric argument, so it adds nothing to the open question. |
| 6 | `Math15Catalog.source06` | `sha256:d5eb872f7f6ef50ae586cae91d79b03154b8b99a5e197066cf8d5584abf18fc0` | Package-authored Lean formalization of Question 6.6 of arXiv:2609.03444 (v1; the catalog cites v2, section 6.4): on near-tight six-speed sets whose maximum loneliness is p/q < 1/6 in lowest terms, is every speed below 3q? The statement requires the speed set to be primitive (no common factor). Scaling a speed set by c keeps its loneliness and q but multiplies every speed by c, so without primitivity the literal question fails for trivial reasons; primitivity is the standard normalization, not an added restriction on the open content. |
| 10 | `Math15Catalog.source10` | `sha256:3571b596aa2552889a8cda8aba83f0c59593db6a0dc8553cd7879f523c4467f4` | Package-authored Lean formalization: every finite tree with exactly two branch vertices, of degrees 4 and 3 (so five leaves), is graceful. Panpa, Imnang and Wasuanankul (J. Appl. Math. 2025, doi:10.1155/jama/5826777) classify five-leaf trees by branch degrees (5), (4,3) and (3,3,3), prove the spider case (Theorem 3.4), and leave this family open in section 4 (Figure 10). |
| 11 | `Math15Catalog.source11` | `sha256:3b166c31578308d2f78ae6c4404be3bd49c64815d1dc066ef9bbf480ebcd917a` | Package-authored Lean formalization: every finite tree with exactly three branch vertices, each of degree 3 (so five leaves), is graceful. Panpa, Imnang and Wasuanankul (J. Appl. Math. 2025, doi:10.1155/jama/5826777) prove the five-leaf spider case (Theorem 3.4) and leave this family open in section 4 (Figure 10). |
| 16 | `Math30Catalog.source16` | `sha256:6851c92e1359fb8774abc091d914b3666c3a3083a97f03f1bf023df2a74dc36e` | Package-authored Lean formalization: an exact bilinear algorithm multiplying 4x4 complex matrices with at most 47 products, from the open problem posed at https://epoch.ai/frontiermath/open-problems/matrix-multiplication. |
| 18 | `Math30Catalog.source18` | `sha256:0b2c494c50df3cd3d4ca028724438e3576a0d1a2d0d5a56f76485db66adc011d` | Package-authored Lean formalization: the border rank of 3x3 complex matrix multiplication is at least 18 (source: arXiv:1911.07981). |
| 20 | `Math30Catalog.source20` | `sha256:98848fdf241eb10f5c9ca8576ca2084a32adb5e75a155ebbc1eb0c7bf9b22521` | Package-authored Lean formalization: a uniform subquadratic upper bound of sensitivity in terms of exact real degree for Boolean functions (source: arXiv:2005.00566v2). |
| 21 | `Math30Catalog.source21` | `sha256:e4f89431c67bbaf4a2695cfe1434d57a72272336315aa5f5d55c501714f02b76` | Package-authored Lean formalization: a uniform cubic upper bound of block sensitivity in terms of ordinary sensitivity (source: ECCC TR26-010). |
| 22 | `Math30Catalog.source22` | `sha256:7d85074569abb05c8183cef2eb968b8a53430a1cf79401790a4117c767993043` | Package-authored Lean formalization: Wilf's inequality for proper numerical semigroups of embedding dimension 4 (source: arXiv:1703.01761). |
| 23 | `Math30Catalog.source23` | `sha256:afce0d65814782c384aee6fa7a554af72c93d6e018348c8495ca2ad8a9213b0e` | Package-authored Lean formalization: Wilf's inequality for proper numerical semigroups whose conductor is at most four times the multiplicity (source: arXiv:1703.01761). |
| 25 | `Math30Catalog.source25` | `sha256:2d762e6cba2e4fd1c52030adb6ef53a371d0437c902c222e160d21c13119fd36` | Package-authored Lean formalization: the third planar Dirichlet Polya inequality, area times lambda_3 at least 12 pi, in the reviewed variational formulation (source: arXiv:2507.04307v3). |
| 26 | `Math30Catalog.source26` | `sha256:76a6988ad5aa908ce2c0ebba5086943a59a333e37a2a7876f62969d05ed8e233` | Package-authored Lean formalization: the fourth planar Dirichlet Polya inequality, area times lambda_4 at least 16 pi, in the reviewed variational formulation (source: arXiv:2507.04307v3). |
| 27 | `Math30Catalog.source27` | `sha256:161e5363b40529175fe04d51c47d4a6bad0aa52c5258fb1f5dde3e74d78fa4bb` | Package-authored Lean formalization: every positive-index Dirichlet Polya inequality on convex planar domains (source: arXiv:2410.04769v2). |
| 28 | `Math30Catalog.source28` | `sha256:f082d84e174b8ecf4cc34a56d92a8654913aa2180b26ed6b6ab3ae86c6635c8a` | Package-authored Lean formalization: every scalar real polynomial minimal graph of degree at most four is affine, in every dimension (source: arXiv:2404.00115v2). |
| 29 | `Math30Catalog.source29` | `sha256:276676286acdf2d9c580ee8489d9c9a1b83507103ce5b580f4478ee5ca1619e8` | Package-authored Lean formalization: every scalar real polynomial minimal graph in dimension eight is affine (source: arXiv:2404.00115v2). |
| 30 | `Math30Catalog.source30` | `sha256:292e1f8f1b71121db89e53999d3e2f399f850cab68800a23764a43c8e94060aa` | Package-authored Lean formalization: for every dimension n >= 8, a degree bound holds uniformly over all scalar real polynomial minimal graphs (source: arXiv:2404.00115v2). |

## Not admitted

| Target | Evaluation | Reason |
| --- | --- | --- |
| 1 | hold | Source cell verified (DS1.18 Table IXa, (4,7) <= 23). Held on the full-admission performance and confidence gate: the UID 10001 decide +kernel benchmark at 22 vertices used relaxed bounds on a parity graph, not a sharp witness or the full pipeline. |
| 2 | hold | Source cell verified (DS1.18 Table IXa, (4,9) = 27-28). Held on the full-admission performance and confidence gate, as target 1, at 27 vertices. |
| 3 | hold | Source cell verified (DS1.18 Table IXa, (7,11) = 37-38). Held on the full-admission performance and confidence gate, as target 1, at 37 vertices. |
| 7 | hold | Correlated Frankl group; see frankl_group. |
| 8 | hold | Correlated Frankl group; see frankl_group. |
| 9 | hold | Correlated Frankl group; see frankl_group. |
| 12 | excluded | Implied by target 10 per the package proof; never an independent reward, whether or not 10 is activated. |
| 13 | hold | Novelty and resource or proof-route feasibility are still open. |
| 14 | hold | External conditional claim review, feasibility and novelty are still open. |
| 15 | hold | No feasible compliant certificate has been demonstrated; novelty review is still open. |
| 17 | hold | Rapidly changing lower-bound literature needs a release-time refresh. |
| 19 | hold | Computed-certificate feasibility and full-size verifier performance are unmeasured. |
| 24 | hold | The catalog literature baseline misses the unconditional m <= 3e result and needs correction and a recheck. |

## Targets 7-9

Target07 and Target09 are existential cover-exclusion cases for rho = 4; they can overlap and neither implies the other. Target08 is the rho = 3 case. One grouped reward whose obligation is the conjunction Target07 AND Target08 AND Target09. Source types are unchanged and no grouped target is created. A grouped reward needs a separate source change, review and owner decision.

## Not claimed

- Activation admits a statement as a reward target. It is not a proof, a refutation, a novelty certificate, or a claim that the statement is true.
- The dated catalog, corpus and primary-source screens are bounded screens, not proof that no solution exists anywhere.
- The numeric bridge for target 5 proves only that k <= s follows from the known bound ML >= 1/5; it proves no Lonely Runner statement.
- Owner approval of this activation and of reward amounts has not been given; this policy records a proposal.
- The proposed matrix-multiplication target 31 is unfrozen and out of scope for this release.
