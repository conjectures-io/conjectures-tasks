#!/usr/bin/env bash
set -euo pipefail
TASKS_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
VALIDATOR_ROOT="${CONJECTURES_VALIDATOR_ROOT:-$TASKS_ROOT/../conjectures-validator}"
cd "$VALIDATOR_ROOT"
export ELAN_HOME="${ELAN_HOME:-$VALIDATOR_ROOT/.elan}"
export PATH="$VALIDATOR_ROOT/.venv/bin:$ELAN_HOME/bin:$PATH"
mkdir -p "$TASKS_ROOT/scratch"
"$VALIDATOR_ROOT/.venv/bin/python" -m verifier task generate --catalog data/catalog.json \
  --theorem Arxiv.id2303_01089.conjecture_1_3 --mode formalized \
  --output "$TASKS_ROOT/scratch/furstenberg-formalized"
