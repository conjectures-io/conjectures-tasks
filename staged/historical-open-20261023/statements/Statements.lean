import Mathlib

/-!
# Seventeen longstanding problems — statements only

All seventeen declarations are closed definitions of propositions. None is asserted
as a theorem or introduced as an axiom. See README.md for sources and the
catalog/upstream duplicate check. Finite labels lose no generality.
-/

open Finset
open scoped BigOperators

noncomputable section
open Classical

namespace FullOldProblems

/-! Shared encodings for finite simple graphs. -/

def maximumDegree {n : ℕ} (G : SimpleGraph (Fin n)) : ℕ :=
  univ.sup fun v => (G.neighborSet v).ncard

/-- The palette bound applies to actual edges only, including when k = 0. -/
def ProperEdgeColoring {n : ℕ} (G : SimpleGraph (Fin n)) (k : ℕ)
    (c : Sym2 (Fin n) → ℕ) : Prop :=
  (∀ e ∈ G.edgeSet, c e < k) ∧
  ∀ u v w : Fin n, G.Adj u v → G.Adj u w → v ≠ w →
    c s(u, v) ≠ c s(u, w)

def EdgeColorable {n : ℕ} (G : SimpleGraph (Fin n)) (k : ℕ) : Prop :=
  ∃ c, ProperEdgeColoring G k c

def HasHamiltonPath {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ a b : Fin n, ∃ w : G.Walk a b, w.IsPath ∧ ∀ v, v ∈ w.support

def HasHamiltonCycle {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ a : Fin n, ∃ w : G.Walk a a, w.IsCycle ∧ ∀ v, v ∈ w.support

/-- Edge disjointness, with full coverage. Vertices may be shared. -/
def PartitionsEdges {n r : ℕ} (G : SimpleGraph (Fin n))
    (E : Fin r → Set (Sym2 (Fin n))) : Prop :=
  (∀ i j : Fin r, i ≠ j → Disjoint (E i) (E j)) ∧
  ∀ e : Sym2 (Fin n), e ∈ G.edgeSet ↔ ∃ i : Fin r, e ∈ E i

/-! 1. Hajós (1968): the exact cycle count for every finite even simple graph. -/

def HajosCycleDecomposition : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∀ G : SimpleGraph (Fin n),
    (∀ v : Fin n, Even (G.neighborSet v).ncard) →
    ∃ r : ℕ, r ≤ (n - 1) / 2 ∧ ∃ a : Fin r → Fin n,
      ∃ w : (i : Fin r) → G.Walk (a i) (a i),
        (∀ i : Fin r, (w i).IsCycle) ∧
        PartitionsEdges G (fun i => (w i).edgeSet)

/-! Multigraphs retain parallel edges as distinct labels. Loops are allowed;
they count twice in degrees, never cross a cut, and cancel in flow conservation.
The chosen endpoint order is a reference orientation, not a restriction. -/

structure MultiGraph (n m : ℕ) where
  tail : Fin m → Fin n
  head : Fin m → Fin n

namespace MultiGraph

def degreeIn {n m : ℕ} (G : MultiGraph n m) (E : Finset (Fin m)) (v : Fin n) : ℕ :=
  (E.filter (fun e => G.tail e = v)).card + (E.filter (fun e => G.head e = v)).card

def cutSize {n m : ℕ} (G : MultiGraph n m) (S : Finset (Fin n)) : ℕ :=
  (univ.filter (fun e => ¬ (G.tail e ∈ S ↔ G.head e ∈ S))).card

/-- An edge is a bridge iff some vertex cut consists of that single edge. -/
def Bridgeless {n m : ℕ} (G : MultiGraph n m) : Prop :=
  ∀ S : Finset (Fin n), G.cutSize S ≠ 1

def Cubic {n m : ℕ} (G : MultiGraph n m) : Prop :=
  ∀ v : Fin n, G.degreeIn univ v = 3

def PerfectMatching {n m : ℕ} (G : MultiGraph n m) (M : Finset (Fin m)) : Prop :=
  ∀ v : Fin n, G.degreeIn M v = 1

/-- Signed integer flows are equivalent to orienting edges and using positive
values 1,...,k-1: reverse an edge whenever its signed value is negative. -/
def IsNowhereZeroFlow {n m : ℕ} (G : MultiGraph n m) (k : ℕ)
    (f : Fin m → ℤ) : Prop :=
  (∀ e, f e ≠ 0 ∧ |f e| < (k : ℤ)) ∧
  ∀ v : Fin n,
    (∑ e ∈ univ.filter (fun e => G.tail e = v), f e) =
    ∑ e ∈ univ.filter (fun e => G.head e = v), f e

def HasNowhereZeroFlow {n m : ℕ} (G : MultiGraph n m) (k : ℕ) : Prop :=
  ∃ f, G.IsNowhereZeroFlow k f

def FourEdgeConnected {n m : ℕ} (G : MultiGraph n m) : Prop :=
  ∀ S : Finset (Fin n), S.Nonempty → S ≠ univ → 4 ≤ G.cutSize S

end MultiGraph

/-! 2. Berge–Fulkerson (1971): six matchings, with multiplicity exactly two. -/

def BergeFulkerson : Prop :=
  ∀ n m : ℕ, ∀ G : MultiGraph n m, G.Bridgeless → G.Cubic →
    ∃ M : Fin 6 → Finset (Fin m),
      (∀ i, G.PerfectMatching (M i)) ∧
      ∀ e : Fin m, (univ.filter (fun i => e ∈ M i)).card = 2

/-! 3. Vizing (1968): independence number of edge-chromatic critical graphs. -/

/-- For finite simple graphs Vizing's theorem makes this equivalent to:
connected, chromatic index Δ+1, and deleting any edge lowers the index to Δ. -/
def DeltaCritical {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  G.Connected ∧ ¬ EdgeColorable G (maximumDegree G) ∧
    ∀ e ∈ G.edgeSet, EdgeColorable (G.deleteEdges {e}) (maximumDegree G)

def VizingIndependence : Prop :=
  ∀ n : ℕ, ∀ G : SimpleGraph (Fin n), DeltaCritical G →
    ∀ S : Finset (Fin n), (∀ u ∈ S, ∀ v ∈ S, ¬ G.Adj u v) → 2 * S.card ≤ n

/-! 4. Chvátal (1973): existence of a universal toughness threshold. -/

def componentsAfterDeletion {n : ℕ} (G : SimpleGraph (Fin n))
    (S : Finset (Fin n)) : ℕ :=
  Nat.card (G.induce {v | v ∉ S}).ConnectedComponent

def IsTough {n : ℕ} (G : SimpleGraph (Fin n)) (t : ℝ) : Prop :=
  ∀ S : Finset (Fin n), 1 < componentsAfterDeletion G S →
    t * (componentsAfterDeletion G S : ℝ) ≤ (S.card : ℝ)

def ChvatalToughness : Prop :=
  ∃ t : ℝ, 0 < t ∧ ∀ n : ℕ, 3 ≤ n →
    ∀ G : SimpleGraph (Fin n), IsTough G t → HasHamiltonCycle G

/-! 5. Lovász (1969): spanning paths in all connected vertex-transitive graphs. -/

def VertexTransitive {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∀ u v : Fin n, ∃ φ : G ≃g G, φ u = v

def LovaszHamiltonPath : Prop :=
  ∀ n : ℕ, ∀ G : SimpleGraph (Fin n),
    G.Connected → VertexTransitive G → HasHamiltonPath G

/-! 6. Kotzig (1963/1964): a perfect 1-factorization for every even order. -/

def SimplePerfectMatching {n : ℕ} (G : SimpleGraph (Fin n))
    (M : Finset (Sym2 (Fin n))) : Prop :=
  (∀ e ∈ M, e ∈ G.edgeSet) ∧
  ∀ v : Fin n, (M.filter (fun e => v ∈ e)).card = 1

def KotzigPerfectFactorization : Prop :=
  ∀ n : ℕ, 4 ≤ n → Even n →
    ∃ M : Fin (n - 1) → Finset (Sym2 (Fin n)),
      (∀ i, SimplePerfectMatching (⊤ : SimpleGraph (Fin n)) (M i)) ∧
      PartitionsEdges (⊤ : SimpleGraph (Fin n)) (fun i => (M i : Set _)) ∧
      ∀ i j, i ≠ j → ∃ a : Fin n,
        ∃ w : (⊤ : SimpleGraph (Fin n)).Walk a a,
          w.IsCycle ∧ (∀ v, v ∈ w.support) ∧
          w.edgeSet = ((M i : Set _) ∪ (M j : Set _))

/-! 7. Riddell–Erdős / Erdős 530 (1969/1973): exact Sidon-subset asymptotic. -/

def IsSidon (S : Finset ℝ) : Prop :=
  ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
    a + b = c + d → (a = c ∧ b = d) ∨ (a = d ∧ b = c)

/-- Both bounds for ℓ(N) / √N → 1 are stated explicitly: a uniform guarantee
for every real N-element set, and an N-element set witnessing the upper bound.
Repeated summands are permitted in the definition of Sidon. -/
def SidonSubsetAsymptotic : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N₀ : ℕ, ∀ N : ℕ, N₀ ≤ N →
    (∀ A : Finset ℝ, A.card = N → ∃ S : Finset ℝ,
      S ⊆ A ∧ IsSidon S ∧ (1 - ε) * Real.sqrt N ≤ (S.card : ℝ)) ∧
    (∃ A : Finset ℝ, A.card = N ∧ ∀ S : Finset ℝ, S ⊆ A → IsSidon S →
      (S.card : ℝ) ≤ (1 + ε) * Real.sqrt N)

/-! 8. Tutte (1954): a nowhere-zero 5-flow on every bridgeless multigraph. -/

def TutteFiveFlow : Prop :=
  ∀ n m : ℕ, ∀ G : MultiGraph n m, G.Bridgeless → G.HasNowhereZeroFlow 5

/-! 9. Tutte (1972): a nowhere-zero 3-flow on every 4-edge-connected multigraph.
This is the separate classical 3-flow conjecture, at its original threshold. -/

def TutteThreeFlow : Prop :=
  ∀ n m : ℕ, ∀ G : MultiGraph n m, G.FourEdgeConnected → G.HasNowhereZeroFlow 3

/-! 10. Riddell–Erdős (1969/1975): the full progression-length family
asked in Erdős 1975, pp. 306–307. The current Erdős 201 page highlights k=3;
we retain every fixed k >= 3 from the original source. -/

def ProgressionFree (k : ℕ) (A : Finset ℤ) : Prop :=
  ∀ a d : ℤ, d ≠ 0 → ¬ ∀ i : Fin k, a + (i.val : ℤ) * d ∈ A

def maxProgressionFreeSubset (k : ℕ) (A : Finset ℤ) : ℕ :=
  (A.powerset.filter (ProgressionFree k)).sup Finset.card

def intervalProgressionNumber (k N : ℕ) : ℕ :=
  maxProgressionFreeSubset k (Icc 1 (N : ℤ))

/-- The minimum is over all N-element integer sets, not only intervals. -/
def universalProgressionNumber (k N : ℕ) : ℕ :=
  sInf {r : ℕ | ∃ A : Finset ℤ, A.card = N ∧ maxProgressionFreeSubset k A = r}

/-- We use the largest progression-free subset convention for R_k, as on
the modern problem page. The original uses the forcing threshold R_k+1;
for each fixed k >= 3, R_k tends to infinity, so the limits are equivalent. -/
def RiddellErdosProgressionRatio : Prop :=
  ∀ k : ℕ, 3 ≤ k → Filter.Tendsto (fun N : ℕ =>
    (intervalProgressionNumber k N : ℝ) / (universalProgressionNumber k N : ℝ))
    Filter.atTop (nhds 1)

/-! 11. Erdős (asked before 1973): linear minimum degree in arbitrarily
large edge-critical four-chromatic graphs. This is the positive answer to
the original yes/no question, not an assertion that the answer is positive. -/

def FourChromaticCritical {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  G.chromaticNumber = 4 ∧ ∀ e ∈ G.edgeSet, (G.deleteEdges {e}).chromaticNumber = 3

def ErdosCriticalMinimumDegree : Prop :=
  ∃ ε : ℝ, 0 < ε ∧ ∀ N : ℕ, ∃ n : ℕ, N ≤ n ∧
    ∃ G : SimpleGraph (Fin n), FourChromaticCritical G ∧
      ∀ v : Fin n, ε * (n : ℝ) ≤ ((G.neighborSet v).ncard : ℝ)

/-! 12. Erdős–Purdy (1971): all four-point subsets with fewer than six
distinct distances, including equal distances on pairs sharing a vertex. -/

abbrev Plane := EuclideanSpace ℝ (Fin 2)

def DegenerateQuadruple (Q : Finset Plane) : Prop :=
  Q.card = 4 ∧ ∃ a ∈ Q, ∃ b ∈ Q, ∃ c ∈ Q, ∃ d ∈ Q,
    a ≠ b ∧ c ≠ d ∧ s(a, b) ≠ s(c, d) ∧ dist a b = dist c d

def degenerateQuadrupleCount (A : Finset Plane) : ℕ :=
  (A.powerset.filter DegenerateQuadruple).card

def ErdosPurdyDegenerateQuadruples : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ N : ℕ, ∀ A : Finset Plane, N ≤ A.card →
    (degenerateQuadrupleCount A : ℝ) ≤ (A.card : ℝ) ^ (3 + ε)

/-! 13. Marcus (1973), independently de Oliveira (1982): determinant of
the sum of arbitrary complex normal matrices. Characteristic polynomials
specify the complete eigenvalue lists with algebraic multiplicities. -/

def HasEigenvalueList {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ)
    (a : Fin n → ℂ) : Prop :=
  A.charpoly = ∏ i, (Polynomial.X - Polynomial.C (a i))

def MarcusDeOliveira : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∀ A B : Matrix (Fin n) (Fin n) ℂ,
    A * A.conjTranspose = A.conjTranspose * A →
    B * B.conjTranspose = B.conjTranspose * B →
    ∀ a b : Fin n → ℂ, HasEigenvalueList A a → HasEigenvalueList B b →
      (A + B).det ∈ convexHull ℝ
        (Set.range (fun σ : Equiv.Perm (Fin n) => ∏ i, (a i + b (σ i))))

/-! 14. Minkowski (documented by 1956): the full inhomogeneous product
bound in every dimension, for every nonsingular real matrix and shift. -/

def MinkowskiInhomogeneousProduct : Prop :=
  ∀ n : ℕ, 1 ≤ n → ∀ A : Matrix (Fin n) (Fin n) ℝ, A.det ≠ 0 →
    ∀ b : Fin n → ℝ, ∃ z : Fin n → ℤ,
      (∏ i, |(∑ j, A i j * (z j : ℝ)) - b i|) ≤ |A.det| / (2 : ℝ) ^ n

/-! 15. Cantoni (1950): planar cubic graphs with exactly three Hamilton
cycles contain a triangle. Cycles are counted by undirected edge sets.
Fáry's theorem makes this straight-line definition of planarity equivalent
to ordinary planarity for finite simple graphs; no convex-position assumption. -/

def StraightLinePlanar {n : ℕ} (G : SimpleGraph (Fin n)) : Prop :=
  ∃ p : Fin n → Plane, Function.Injective p ∧
    (∀ u v, G.Adj u v → ∀ w, p w ∈ segment ℝ (p u) (p v) → w = u ∨ w = v) ∧
    ∀ u v x y, G.Adj u v → G.Adj x y → s(u, v) ≠ s(x, y) →
      ∀ z ∈ segment ℝ (p u) (p v), z ∈ segment ℝ (p x) (p y) →
        (z = p u ∨ z = p v) ∧ (z = p x ∨ z = p y)

def hamiltonCycleEdgeSets {n : ℕ} (G : SimpleGraph (Fin n)) :
    Set (Finset (Sym2 (Fin n))) :=
  {E | ∃ a : Fin n, ∃ w : G.Walk a a,
    w.IsCycle ∧ (∀ v, v ∈ w.support) ∧ w.edges.toFinset = E}

def Cantoni : Prop :=
  ∀ n : ℕ, ∀ G : SimpleGraph (Fin n), StraightLinePlanar G →
    (∀ v, (G.neighborSet v).ncard = 3) → (hamiltonCycleEdgeSets G).ncard = 3 →
      ∃ a b c : Fin n, G.Adj a b ∧ G.Adj b c ∧ G.Adj c a

/-! 16. Marcus (1965): permanent of a matrix versus the permanent of its
block permanents, including the original equality characterization. The whole
matrix is complex Hermitian positive semidefinite; off-diagonal blocks need
not themselves be positive semidefinite. -/

open scoped ComplexOrder

def matrixBlock {m k : ℕ}
    (A : Matrix (Fin m × Fin k) (Fin m × Fin k) ℂ) (i j : Fin m) :
    Matrix (Fin k) (Fin k) ℂ := fun a b => A (i, a) (j, b)

def blockPermanentMatrix {m k : ℕ}
    (A : Matrix (Fin m × Fin k) (Fin m × Fin k) ℂ) : Matrix (Fin m) (Fin m) ℂ :=
  fun i j => (matrixBlock A i j).permanent

def MarcusBlockPermanent : Prop :=
  ∀ m k : ℕ, 1 ≤ m → 1 ≤ k →
    ∀ A : Matrix (Fin m × Fin k) (Fin m × Fin k) ℂ, A.PosSemidef →
      (blockPermanentMatrix A).permanent ≤ A.permanent ∧
      (2 ≤ k → (∀ i, (matrixBlock A i i).PosDef) →
        (A.permanent = (blockPermanentMatrix A).permanent ↔
          ∀ i j : Fin m, i ≠ j → ∀ a b : Fin k, A (i, a) (j, b) = 0))

/-! 17. Wang (1974): can a real Hadamard matrix of order greater than two
have zero permanent? We encode the negative answer, in every order, without
restricting to Sylvester or circulant matrices. Proving or disproving this
proposition answers the original yes/no question. -/

def IsSignHadamard {n : ℕ} (H : Matrix (Fin n) (Fin n) ℤ) : Prop :=
  (∀ i j, H i j = 1 ∨ H i j = -1) ∧ H * H.transpose = (n : ℤ) • 1

def WangHadamardPermanentNonvanishing : Prop :=
  ∀ n : ℕ, 2 < n → ∀ H : Matrix (Fin n) (Fin n) ℤ,
    IsSignHadamard H → H.permanent ≠ 0

def statements : Fin 17 → Prop := ![
  HajosCycleDecomposition, BergeFulkerson, VizingIndependence,
  ChvatalToughness, LovaszHamiltonPath, KotzigPerfectFactorization,
  SidonSubsetAsymptotic, TutteFiveFlow, TutteThreeFlow,
  RiddellErdosProgressionRatio, ErdosCriticalMinimumDegree,
  ErdosPurdyDegenerateQuadruples, MarcusDeOliveira,
  MinkowskiInhomogeneousProduct, Cantoni, MarcusBlockPermanent,
  WangHadamardPermanentNonvanishing]

end FullOldProblems
