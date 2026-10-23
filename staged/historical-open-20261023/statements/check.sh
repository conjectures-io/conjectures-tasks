#!/usr/bin/env bash
set -euo pipefail
draft_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
image_tag=${FULL_OLD_PROBLEMS_IMAGE:-formal-conjectures-verifier:classical-6314587}
docker run --rm --network none -e LEAN_NUM_THREADS=1 \
  -v "$draft_dir:/draft:ro" --entrypoint /bin/bash "$image_tag" /draft/check-in-container.sh
