#!/usr/bin/env bash
set -euo pipefail

mkdir -p out
javac --release 21 -d out src/main/java/dev/onebrc/CalculateAverage.java
java -cp out dev.onebrc.CalculateAverage "${1:-measurements.txt}"
