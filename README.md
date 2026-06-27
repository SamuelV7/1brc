# 1 Billion Row Challenge (1brc)

Java/Nix scaffold for the [1brc](https://github.com/gunnarmorling/1brc) challenge.

## Requirements

- Nix with flakes enabled

## Quick start

```sh
nix develop
./scripts/generate.sh 1000000   # create measurements.txt with 1M rows
./scripts/run.sh                # compile and run the Java solution
```

For the full challenge dataset:

```sh
./scripts/generate.sh 1000000000
./scripts/run.sh
```

`measurements.txt` lines have this format:

```txt
Station Name;12.3
```

The program prints sorted station aggregates:

```txt
{Station=min/mean/max, ...}
```

## Benchmarking

Inside `nix develop`:

```sh
hyperfine './scripts/run.sh'
```

## Project layout

- `flake.nix` - reproducible dev shell with JDK 21, Python, and hyperfine
- `scripts/generate.sh` - generate test data
- `scripts/run.sh` - compile and run solution
- `src/main/java/dev/onebrc/CalculateAverage.java` - baseline Java solution
