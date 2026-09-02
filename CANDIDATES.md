# Batch two candidates

`tiers/tier-1/candidate-batch-2.json` is the candidate set the 2026-09-02 repin onto Formal
Conjectures `8432eac9` made available, and **nothing in it is admissible**. It records the
mechanical facts an audit starts from; it is not a selection, and no file the submission or
verification path reads mentions it. Admitting any of these means adding entries to
`selection-audit.json` and `task-targets.json` and rebuilding the pool, which moves every task
identity in the tier — so they are held for one batch rather than trickled in.

## What is in it

50 candidates: 44 Erdős, 6 Green's Open Problems, over 36 problem numbers.

- **37** are declarations that did not exist in the catalog at the previous pin. Those are the ones
  upstream added, mostly in new problem files: Erdős 5, 60, 80, 94, 105, 205, 337, 367, 450, 538,
  628, 649, 660, 769, 785, 955, 959, 967, 1035, 1044, 1050, 1088, 1109, 1110, and Green 21, 53, 64.
- **12** existed already and became eligible. Most are `answer(sorry) ↔ P` statements that used to
  compile with the Prop-valued hole surviving into the type, classifying as
  `PROP_ANSWER_WRAPPER` and therefore inadmissible; under Lean 4.33.1 the hole elaborates away and
  they classify as direct propositions. `Erdos263.erdos_263.parts.ii` is a different case: upstream
  moved it from `research solved` back to `research open`.
- **1** is `Erdos354.erdos_354.parts.ii`, included by request. It is worth its own note: before
  this pin the statement read `∃ γ ∈ Set.Ioo 1 2, … interleave α β 2`, where the bound variable
  `γ` went unused, so the whole thing followed trivially from `parts.i`. Upstream fixed the body to
  use `γ`, which makes it a genuinely distinct and harder statement. `parts.i` needed nothing — its
  only upstream change was to the docstring.

## Lapsed mechanical retirements

`lapsed_mechanical_retirements` in the same file lists retired targets whose retirement reason was
mechanical and has stopped being true at this pin. Two are in the audited families:

- `Erdos510.erdos_510` — retired 2026-08-12 as `TYPE_DEPENDS_ON_SORRY`, because the Prop-valued
  `answer(sorry)` survived in the compiled type. It now classifies as `DIRECT_PROP`.
- `Erdos20.erdos_20` — a legacy retirement with no recorded reason, in the same
  `PROP_ANSWER_WRAPPER` class.

Neither is readmitted here. A retired name is refused by `select_task_declarations` by name **or**
by canonical type, so readmission is an audit decision plus an explicit edit to
`retired-source-theorems.json` — and for `Erdos20` the reason was never written down, so there is
nothing to check the lapse against. That gap is worth closing: 58 of the retirements in the audited
families predate `RETIREMENTS.md` and have no recorded reason, which means they cannot be
re-evaluated when a pin moves without reading the commits that made them.

## What an audit still owes each candidate

The worksheet fills in only what the catalog and the pinned status sources can establish: family,
source path and problem number, canonical type hash, upstream category, the open pull requests
touching the source file, and the Erdős Problems database status. Still missing, and required by
`load_selection_audit`:

- `feasibility_signals` — at least one, from the five the policy allows;
- `source_status` — for a Green candidate, from the Open Problems document rather than the Erdős
  database;
- the exact-statement and equivalent-form literature screen, which is what the 2026-08-05 and
  2026-08-12 audits did and which this repin did not re-run;
- confirmation that no open pull request resolves or corrects the candidate itself. The worksheet
  records which pull requests touch each source *file*, which is a wider net than that and needs
  reading — it is how Green 72 was caught.
