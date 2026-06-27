#!/usr/bin/env bash
set -euo pipefail

rows="${1:-1000000}"
out="${2:-measurements.txt}"

python3 scripts/generate_measurements.py "$rows" "$out"
