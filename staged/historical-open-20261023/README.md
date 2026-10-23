# Full historical open problems

This release adds 16 complete historical questions and 32 proof/refutation bundles.
The catalog and admission policy exclude original problem 15, Cantoni, following the
user-supplied full counterexample claim by Ibrahim Cahit on October 23, 2026.
The construction has not been checked; this is an exclusion decision, not a finding
that Cantoni is disproved. The references and decision are in `excluded-problems.json`.

`statements/` is the original historical statement package and audit evidence. It includes
Cantoni and predates this exclusion. It is retained only for provenance; the authoritative
release selection is `tiers/tier-1/selection-audit.json`, with the current status review in
`tiers/tier-1/historical-open-status-audit.json`. No Cantoni tasks are admitted.

All 16 retained statements are full questions, not weakened variants. Their bounded claim
searches date to October 21–22, 2026; no full resolution claim was identified for them.
These searches cannot establish that no claim exists. Formalization does not prove the
statements or independently establish equivalence to their informal sources.

The release uses Lean 4.35.0-rc2 and Mathlib 065356127b1dc0016f66b7283ce0ce2c4055aa55.
All 548 existing active bundle identities and all earlier verification admissions remain
unchanged. The old worker continues serving old admissions; a separate worker serves the
new source snapshot. These are difficult longstanding problems with no promise of an
imminent solution.
