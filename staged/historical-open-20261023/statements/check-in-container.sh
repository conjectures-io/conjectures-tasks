#!/usr/bin/env bash
set -euo pipefail
task_build_dir=$(mktemp -d)
lake env lean --version
git -C .lake/packages/mathlib rev-parse HEAD
lake env lean --root=/draft -o "$task_build_dir/Statements.olean" /draft/Statements.lean
FULL_OLD_PROBLEMS_BUILD="$task_build_dir" lake env bash -c '
  export LEAN_PATH="$FULL_OLD_PROBLEMS_BUILD:$LEAN_PATH"
  exec lean --root=/draft /draft/Audit.lean
'
printf '%s\n' 'PASS: statement compilation, boundary checks, and dependency audit completed.'
