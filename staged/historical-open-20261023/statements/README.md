# Seventeen complete longstanding open problems

Prepared 2026-10-21; **eight added on 2026-10-22, bringing the total to seventeen**.
The original nine are unchanged. This replaces the earlier `old-open-ten-20261021`
selection after the request for full problems and exclusion of full proof or
disproof claims, including unaccepted claims. Each entry preserves the scope of
a historical conjecture or yes/no question. All date from 1975 or earlier.
No matching statement was found in the checked local catalog or upstream
`google-deepmind/formal-conjectures` repository.

[Statements.lean](Statements.lean) contains seventeen closed `Prop` definitions in
`FullOldProblems`, plus a `Fin 17` registry. These are formalized statements,
not proofs or assumptions that the conjectures hold. A proof or disproof
would resolve the corresponding question. They have concise formulations,
but these remain major research problems; no short-solution likelihood is
being claimed.

| # | Complete problem | Date | Exact scope |
|---|---|---|---|
| 1 | Hajós cycle decomposition | 1968 | Every nonempty finite simple graph with all degrees even has an edge partition into at most \(\lfloor(n-1)/2\rfloor\) simple cycles. |
| 2 | Berge–Fulkerson | 1971 | Every bridgeless cubic multigraph has six perfect matchings, with each edge in exactly two; matchings may repeat. |
| 3 | Vizing independence number | 1968 | Every connected \(\Delta\)-critical simple graph satisfies \(\alpha(G)\le n/2\). |
| 4 | Chvátal toughness | 1973 | There exists a universal \(t>0\) such that every \(t\)-tough simple graph with at least three vertices has a Hamilton cycle. |
| 5 | Lovász Hamiltonian path | 1969 | Every connected finite vertex-transitive graph has a spanning simple path. |
| 6 | Kotzig perfect 1-factorization | 1963/1964 | For every even \(n\ge4\), \(K_n\) partitions into \(n-1\) perfect matchings, every pair of which forms a Hamilton cycle. |
| 7 | Riddell–Erdős Sidon subsets, Erdős 530 | 1969; sharp bound recorded 1973 | If \(\ell(N)\) is the largest universally guaranteed size of a Sidon subset in an arbitrary \(N\)-element real set, then \(\ell(N)\sim\sqrt N\). |
| 8 | Tutte 5-flow | 1954 | Every finite bridgeless multigraph admits a nowhere-zero integer 5-flow. |
| 9 | Tutte 3-flow | 1972 | Every finite 4-edge-connected multigraph admits a nowhere-zero integer 3-flow. |
| 10 | Riddell–Erdős progression ratio, related to Erdős 201 | 1969; full ratio question explicit 1975 | For every fixed \(k\ge3\), \(R_k(N)/G_k(N)\to1\), comparing interval progression-free subsets with the worst arbitrary \(N\)-element integer set. |
| 11 | Erdős critical minimum degree, Erdős 1032 | Before 1973 | Arbitrarily large edge-critical four-chromatic graphs with minimum degree at least \(\varepsilon n\), for a fixed \(\varepsilon>0\). |
| 12 | Erdős–Purdy degenerate quadruples, Erdős 1087 | 1971 | At most \(n^{3+o(1)}\) four-point subsets with fewer than six distinct distances, in every planar \(n\)-point set. |
| 13 | Marcus–de Oliveira | 1973 | For all complex normal matrices, the determinant of their sum belongs to the real convex hull of all permuted eigenvalue-sum products. |
| 14 | Minkowski inhomogeneous product | Documented by 1956 | All dimensions, nonsingular real linear forms and shifts; sharp product bound \(2^{-n}|\det A|\). |
| 15 | Cantoni | 1950 | Every planar cubic simple graph with exactly three undirected Hamilton cycles contains a triangle. |
| 16 | Marcus block permanent | 1965 | Permanent dominates the permanent of block permanents, for all complex Hermitian positive semidefinite block matrices; includes the equality characterization. |
| 17 | Wang's Hadamard permanent question | 1974 | Every real Hadamard matrix of order greater than two has nonzero permanent. |

Entries 11 and 17 encode, respectively, the positive and negative answers to
the original yes/no questions. Defining these propositions does not assume
those answers. Entry 10 includes every progression length in the 1975 question,
not just the length-three case highlighted on the current problem page.

The two Tutte entries are distinct classical conjectures with their respective
original hypotheses, not newly chosen parameter variants. For example, the
3-flow statement retains 4-edge-connectivity, not the proved higher-connectivity
thresholds. A 5-flow does not provide the 3-flow required by the other problem.

## Sources and current status

1. **Hajós:** [Botler et al.](https://arxiv.org/abs/1706.04334) give the 1968 date
   and sharp bound. [Kim, October 2026](https://arxiv.org/abs/2610.07840v2)
   proves the linear-order bound, explicitly describing it as Hajós up to a
   constant factor. The sharp conjecture is the entry here.
2. **Berge–Fulkerson:** [Magalhães Júnior–Silva, July 2026](https://arxiv.org/abs/2607.29511)
   give the exact six-matching statement and describe it as open since 1971.
3. **Vizing independence:** [Qi–Zhao–Miao, 2025](https://www.ort.shu.edu.cn/CN/10.15960/j.cnki.issn.1007-6093.2025.01.019)
   state the 1968 conjecture and its open status.
   [Cao et al.](https://arxiv.org/abs/1805.05996) give the definition of
   \(\Delta\)-critical used here.
4. **Toughness:** [Shan–Tanyel](https://arxiv.org/abs/2506.12684), subsequently
   [published in 2026](https://doi.org/10.1016/j.disc.2026.115364), state the
   original 1973 existential conjecture and its open status.
5. **Lovász:** [Li–Methuku, October 2026](https://arxiv.org/abs/2609.38135v2)
   state the 1969 question. Their nearly linear path bound does not give a
   spanning path.
6. **Perfect factorization:** [Cheng–Sgueglia, July 2026](https://arxiv.org/html/2607.09459)
   state the full conjecture and date its proposal to 1963; the cited Kotzig
   paper appeared in 1964. Their asymptotic result makes only a large fraction
   of the matchings pairwise perfect, not all \(n-1\).
7. **Sidon subsets:** [Erdős 1973, printed page 120](https://www.renyi.hu/~p_erdos/1973-21.pdf#page=4)
   records the real-set question, repeated summands included, and conjectures
   the sharp upper bound. The scanned page was inspected directly.
   [Bailleul–Riblet, May 2026](https://arxiv.org/abs/2605.03181) improve the
   lower constant to \(1/(3\sqrt3)\), leaving the conjectured constant 1 open.
   [Problem 530](https://www.erdosproblems.com/530) also records the history.
8. **5-flow:** [West's problem page](https://dwest.web.illinois.edu/openp/tut5flow.html)
   records 1954. [Li et al., January 2026](https://arxiv.org/abs/2601.12036)
   give partial results supporting the conjecture.
9. **3-flow:** [de Jong](https://arxiv.org/abs/2011.02140) gives 1972;
    [Li–Li, September 2026](https://arxiv.org/abs/2609.08377) retain the exact
    4-edge-connected conjecture while proving restricted cases.

10. **Progression ratio:** [Erdős 1975, pp. 306–307](https://www.numdam.org/article/AST_1975__24-25__295_0.pdf#page=14)
    asks the ratio question for every progression length. The scanned page was
    inspected. [Problem 201](https://www.erdosproblems.com/201) records the
    history and the constant-factor result, which does not establish limit 1.
11. **Critical degree:** [Erdős 1993, p. 341](https://doi.org/10.1080/16073606.1993.9631741)
    says the question was asked more than twenty years earlier, as recorded by
    [Problem 1032](https://www.erdosproblems.com/1032). This is retrospective
    dating, not an identified exact proposal year. The
    [discussion](https://www.erdosproblems.com/forum/thread/1032) links a 2026
    upper bound with coefficient \(3/10\); that does not decide linear growth.
12. **Quadruples:** [Erdős–Purdy 1971, p. 251](https://users.renyi.hu/~p_erdos/1971-20.pdf)
    explicitly asks the \(n^{3+\varepsilon}\) bound. The original text and
    [Problem 1087](https://www.erdosproblems.com/1087) were checked.
13. **Marcus–de Oliveira:** [Bebiano–da Providência 2025](https://doi.org/10.3390/math13050711)
    gives the 1973 origin and full statement.
    [Kovacec 2026](https://www.mat.uc.pt/preprints/ps/p2611.pdf) proposes a
    stronger conjecture; it does not prove the general one.
14. **Minkowski:** [Birch–Swinnerton-Dyer 1956](https://doi.org/10.1112/S0025579300000863)
    supplies a conservative documented-by date.
    [Kathuria–Raka 2015](https://insa.nic.in/writereaddata/UpLoadedFiles/IJPAM/Vol46_2015_3_ART05.pdf)
    states the complete conjecture; low-dimensional results leave the full
    dimension-independent question unresolved.
15. **Cantoni:** [Bondy–Murty, Appendix A](https://www.facom.ufu.br/~nunes/teoria%20dos%20grafos/graph-theory.pdf)
    dates it to 1950. [Goedgebeur–Meersman–Zamfirescu](https://arxiv.org/abs/1812.05650)
    verify orders through 48. [Zamfirescu 2024](https://ecajournal.haifa.ac.il/Conference/ConfWeb2224/Abs24_Zamfirescu.pdf)
    retains the exact conjecture among open problems.
16. **Marcus blocks:** [Wanless 2022, Conjecture 3](https://arxiv.org/html/2202.01867v1)
    gives the inequality and equality clause from Marcus–Minc 1965.
    [Lavi's October 2026 progress record](https://yair-lavi.com/mincs-list/conjecture-9/index.html)
    lists only partial results and explains the necessary block-size-two
    threshold for the equality clause.
17. **Wang:** the question originates in
    [Wang 1974](https://doi.org/10.1007/BF02760844).
    [Wanless 2005](https://users.monash.edu.au/~iwanless/papers/wangconjLAMA.pdf)
    and [Lavi's October 2026 record](https://yair-lavi.com/mincs-list/problem-5/index.html)
    retain the general question. [Chabaud 2018](https://arxiv.org/abs/1802.08001)
    concerns only Sylvester matrices.

The original nine were screened on 2026-10-21; the eight additions were screened
on 2026-10-22. These are dated, bounded checks, not a guarantee that nobody has
ever posted a purported solution.

## Claimed-proof exclusion and difficulty

**Discarded: Behzad–Vizing total coloring.**
[Murthy's preprint](https://arxiv.org/abs/2003.09658v3), first posted in 2020,
explicitly claims the full result. It has been removed from `Statements.lean`,
the registry, and the active manifest entries. The exclusion applies even
though later literature continues to call the conjecture open. The discard
record is retained in `manifest.json`.

The updated selection rule excludes any identified full proof or disproof
claim for the exact question, regardless of acceptance. A proved special case
or asymptotic weakening does not resolve the full question. No full-resolution
claim was found for the retained problems in their dated screening;
this is not an exhaustive guarantee. See
[research/claim-screen.json](research/claim-screen.json).
The eight additions have a separate
[screening record](research/add-eight-20261022/claim-screen.json), including
discarded candidates and explanations of apparent proof-title matches that
address only special cases or different questions.

**Difficulty assessment:** this collection is generally a substantial step up
from the previous Math30 restricted research targets (specific graceful-tree
families, restricted lonely-runner spectra, conductor-bounded Wilf, and
individual low-index Pólya bounds). The full Tutte, Berge–Fulkerson, Lovász,
and toughness conjectures are major breakthrough targets. This is a qualitative
judgment, not a measurable ranking or a claim that each new problem exceeds
every earlier one. Some earlier targets were already exceptionally hard.
The original shortlist was too ambitious for a brief emphasizing plausible
near-term solutions. See [research/difficulty-comparison.md](research/difficulty-comparison.md).
The eight additions include less prominent standalone questions, but there is
no reliable difficulty ordering or promise of near-term solutions. The full
Minkowski and Marcus–de Oliveira conjectures remain especially ambitious.
The provisional self-avoiding-walk and infinite-cardinal partition questions
were left out in favor of the two concrete permanent questions.

## Existing catalog and statement-repository checks

- Local catalog: `data/catalog.json`, 5,190 declarations, repository commit
  `8432eac998110a563e03df65a28c117e97c8c142`. The active allowlist and vendored
  statements were also searched. Hashes and matches are in
  [research/local-search.json](research/local-search.json).
- Upstream observed `main`: `2a315101d438a68c0ebdf22b7485ac731624efed`.
  The complete file tree and name/subject code searches were checked;
  [research/upstream-search.json](research/upstream-search.json) records results.
- For the eight additions, observed upstream `main` was
  `3b7c94ecc72b6d42af9ed7028ad8184cbce1aaa8` on 2026-10-22. See their
  [local search](research/add-eight-20261022/local-search.json) and
  [upstream search](research/add-eight-20261022/upstream-search.json).
  The upstream permanent identities, doubly stochastic inequalities, Hadamard
  existence conjecture and circulant Hadamard theorem were inspected and are
  different questions. No files for Erdős 201, 1032 or 1087 were in the tree.
- Same-name files were read: upstream **VizingConjecture** concerns domination
  of Cartesian products; **Chvatal** concerns intersecting families;
  **KotzigConjecture** concerns cyclic tree decompositions; and
  **LovaszPlummerConjecture** concerns second Hamilton cycles. These are
  different statements from the entries here.
- Sidon hits concern intervals, special ambient sets, infinite sequences,
  finite groups, or other extremal questions. No arbitrary-real-set sharp
  guarantee matching Erdős 530 was found; upstream has no `ErdosProblems/530.lean`.
- Ryser's full odd-order Latin transversal conjecture **was found** in
  `Paper/LatinSquare.lean` and excluded from this new collection.

This is a documented no-match search, not a machine proof that no equivalent
statement exists under an unexpected encoding. Nothing was added to the
production catalog or active task pool.

## Encoding review and validation

Finite graphs use labels `Fin n`; this includes every finite graph up to
relabeling. Multigraphs label edges separately, retaining parallel edges and
loops. Loops contribute twice to degree and cancel in flow conservation.
The flow bound is strict: \(0<|f(e)|<k\), with signed integers permitting both
orientations. Bridgelessness excludes exactly the one-edge cuts.

Simple-graph edge colors use unordered pairs and constrain only actual edges,
so the edgeless graph is correctly 0-edge-colorable. Criticality uses
the original graph's maximum degree after deleting an edge. Toughness counts
all components of the induced graph after deleting any vertex set, with the
threshold chosen before the graph. The Sidon statement contains both sides
of the sharp asymptotic, uniformly over all real ambient sets, and includes
equal summands.

New-entry review: progression differences must be nonzero, and the worst-case
minimum ranges over arbitrary integer sets. The original progression forcing
threshold differs from the maximum-free-size convention by one; for fixed
\(k\ge3\) this does not change the ratio limit. Quadruples are counted once as
four-element subsets, and equal-distance pairs may share a vertex. Eigenvalue
lists preserve algebraic multiplicities. Cantoni counts undirected edge sets,
so reversing a Hamilton cycle does not create a new one. Its straight-line
planarity predicate covers finite simple planar graphs by Fáry's theorem.
Marcus's whole block matrix is complex positive semidefinite, with no positivity
restriction on individual off-diagonal blocks; the equality clause requires
positive definite diagonal blocks and block size at least two. Wang's integer
sign-matrix encoding is equivalent to the real one because every entry is
\(1\) or \(-1\). These source-to-statement equivalences were reviewed manually;
compilation alone does not certify mathematical fidelity.

Run `bash check.sh`. The checked environment is Lean **4.33.1**, Mathlib
`0df444a360eaa60ab8c11dca51a86af692955474`, Docker image
`formal-conjectures-verifier:classical-6314587`. Validation passes:
statement compilation, 23 boundary examples, and a transitive dependency
audit of all seventeen definitions and the registry. Only the standard Lean axioms
`propext`, `Classical.choice`, and `Quot.sound` occur. There are no `sorry`s,
conjecture axioms, or theorem declarations asserting these open problems.
See [check.log](check.log), [Audit.lean](Audit.lean), and [manifest.json](manifest.json).
