import Statements
import Lean.Util.CollectAxioms

open FullOldProblems Finset
open scoped BigOperators

/- Boundary checks target possible encoding errors, not the open conjectures. -/

example (n : ℕ) : EdgeColorable (⊥ : SimpleGraph (Fin n)) 0 := by
  refine ⟨fun _ => 0, ?_, ?_⟩ <;> simp

example : ¬ EdgeColorable (⊤ : SimpleGraph (Fin 2)) 0 := by
  rintro ⟨c, h, _⟩
  have h01 : s((0 : Fin 2), 1) ∈ (⊤ : SimpleGraph (Fin 2)).edgeSet := by simp
  have := h _ h01
  omega

example {n : ℕ} (G : SimpleGraph (Fin n)) [DecidableRel G.Adj] (v : Fin n) :
    (G.neighborSet v).ncard = G.degree v := by
  classical
  calc
    _ = (G.neighborFinset v : Set (Fin n)).ncard :=
      congrArg Set.ncard (G.coe_neighborFinset v).symm
    _ = (G.neighborFinset v).card := Set.ncard_coe_finset _
    _ = G.degree v := rfl

example : HasHamiltonPath (⊥ : SimpleGraph (Fin 1)) := by
  refine ⟨0, 0, SimpleGraph.Walk.nil, ?_, ?_⟩
  · simp
  · intro v
    have : v = 0 := Subsingleton.elim _ _
    simp [this]

example (n : ℕ) :
    PartitionsEdges (⊥ : SimpleGraph (Fin n)) (Fin.elim0 : Fin 0 → Set (Sym2 (Fin n))) := by
  constructor
  · intro i
    exact Fin.elim0 i
  · intro e
    simp

/- A two-vertex cubic multigraph with three distinct parallel edges. -/
private def parallelThree : MultiGraph 2 3 := ⟨fun _ => 0, fun _ => 1⟩

example : parallelThree.Cubic := by
  intro v
  fin_cases v <;> norm_num [MultiGraph.degreeIn, parallelThree]

example : parallelThree.cutSize {0} = 3 := by
  norm_num [MultiGraph.cutSize, parallelThree]

example : parallelThree.PerfectMatching {0} := by
  intro v
  fin_cases v <;> norm_num [MultiGraph.degreeIn, parallelThree]

/- Three reference-oriented parallel edges need signed values, e.g. 1, 1, -2. -/
example : parallelThree.IsNowhereZeroFlow 3 ![1, 1, -2] := by
  constructor
  · intro e
    fin_cases e <;> norm_num
  · intro v
    fin_cases v <;>
      norm_num [parallelThree, Fin.sum_univ_succ]

/- A loop contributes two to degree and zero to every cut. -/
private def oneLoop : MultiGraph 1 1 := ⟨fun _ => 0, fun _ => 0⟩

example : oneLoop.degreeIn univ 0 = 2 := by
  norm_num [MultiGraph.degreeIn, oneLoop]

example (S : Finset (Fin 1)) : oneLoop.cutSize S = 0 := by
  simp [MultiGraph.cutSize, oneLoop]

example : oneLoop.IsNowhereZeroFlow 5 (fun _ => 4) := by
  constructor
  · norm_num
  · intro v
    rfl

example : ¬ oneLoop.IsNowhereZeroFlow 5 (fun _ => 5) := by
  intro h
  have := (h.1 0).2
  norm_num at this

/- Repeated summands matter: 0+2=1+1 excludes this set from Sidon sets. -/
example : ¬ IsSidon ({0, 1, 2} : Finset ℝ) := by
  intro h
  have := h 0 (by simp) 2 (by simp) 1 (by simp) 1 (by simp) (by norm_num)
  norm_num at this

/- Nonzero common difference excludes 0,1,2 but allows a singleton. -/
example : ¬ ProgressionFree 3 ({0, 1, 2} : Finset ℤ) := by
  intro h
  apply h 0 1 (by norm_num)
  intro i
  fin_cases i <;> norm_num

example : ProgressionFree 3 ({7} : Finset ℤ) := by
  intro a d hd h
  have h0 := h 0
  have h1 := h 1
  simp at h0 h1
  omega

/- A diagonal matrix retains repeated eigenvalues with their multiplicity. -/
example : HasEigenvalueList (Matrix.diagonal (![2, 2] : Fin 2 → ℂ)) ![2, 2] := by
  exact Matrix.charpoly_diagonal _

example : ¬ HasEigenvalueList (Matrix.diagonal (![2, 2] : Fin 2 → ℂ)) ![2, 3] := by
  intro h
  have he := congrArg (Polynomial.eval (3 : ℂ)) h
  norm_num [HasEigenvalueList, Matrix.charpoly_diagonal, Fin.prod_univ_succ] at he

/- The sharp scalar Minkowski constant is 1/2, not 1 or 1/4. -/
example : (∏ i : Fin 1, |(∑ j : Fin 1,
    (1 : Matrix (Fin 1) (Fin 1) ℝ) i j * ((0 : Fin 1 → ℤ) j : ℝ)) - 1/2|) =
    |(1 : Matrix (Fin 1) (Fin 1) ℝ).det| / (2 : ℝ) ^ 1 := by
  norm_num

/- Counting edge sets identifies the two orientations of a Hamilton cycle. -/
example {n : ℕ} (G : SimpleGraph (Fin n)) (a : Fin n) (w : G.Walk a a) :
    w.reverse.edges.toFinset = w.edges.toFinset := by
  simp

/- Blocks of size one recover the original matrix, so the nontrivial
Marcus equality clause must not apply to block size one. -/
example {m : ℕ} (B : Matrix (Fin m) (Fin m) ℂ) :
    blockPermanentMatrix (fun (i a : Fin m × Fin 1) => B i.1 a.1) = B := by
  ext i j
  simp [blockPermanentMatrix, matrixBlock, Matrix.permanent]

/- The order-two exception in Wang's question is essential. -/
example : IsSignHadamard (!![1, 1; 1, -1] : Matrix (Fin 2) (Fin 2) ℤ) := by
  constructor
  · intro i j
    fin_cases i <;> fin_cases j <;> norm_num
  · ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [Matrix.mul_apply, Fin.sum_univ_succ, Matrix.one_apply]

example : (!![1, 1; 1, -1] : Matrix (Fin 2) (Fin 2) ℤ).permanent = 0 := by
  decide

/- Audit the bodies transitively, not merely the type `Prop`. -/
open Lean Elab Command in
run_elab do
  let names : Array Name := #[
    ``HajosCycleDecomposition, ``BergeFulkerson,
    ``VizingIndependence, ``ChvatalToughness, ``LovaszHamiltonPath,
    ``KotzigPerfectFactorization, ``SidonSubsetAsymptotic,
    ``TutteFiveFlow, ``TutteThreeFlow,
    ``RiddellErdosProgressionRatio, ``ErdosCriticalMinimumDegree,
    ``ErdosPurdyDegenerateQuadruples, ``MarcusDeOliveira,
    ``MinkowskiInhomogeneousProduct, ``Cantoni, ``MarcusBlockPermanent,
    ``WangHadamardPermanentNonvanishing]
  for name in names do
    let info ← getConstInfo name
    unless info.type == .sort .zero do
      throwError "{name} is not a closed proposition definition"
    let .defnInfo _ := info | throwError "{name} must be a definition"
    let axs ← collectAxioms name
    let bad := axs.filter (fun a => a != ``propext && a != ``Classical.choice && a != ``Quot.sound)
    unless bad.isEmpty do
      throwError "{name} has unexpected axioms: {bad}"
    logInfo m!"AUDITED {name}: {axs}"
  let axs ← collectAxioms ``statements
  unless axs.all (fun a => a == ``propext || a == ``Classical.choice || a == ``Quot.sound) do
    throwError "Registry has unexpected axioms: {axs}"
  logInfo "PASS: seventeen closed proposition definitions; no conjecture axioms or admitted dependencies."
