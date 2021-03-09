#! /usr/bin/env bash

set -euxo pipefail

if [[ ! -f $cg_clif_dir/build/cargo.sh ]]; then
    echo '$cg_clif_dir env var not set';
    exit 1
fi

echo "llvm without lld"
hyperfine -w 5 \
  --export-csv timings.csv \
  -n llvm-no-lld \
  'touch src/main.rs && CARGO_TARGET_DIR=target/llvm cargo build' \
  -n llvm-with-lld \
  'touch src/main.rs && CARGO_TARGET_DIR=target/llvm_lld RUSTFLAGS="-C link-arg=-fuse-ld=lld" cargo build' \
  -n clif-no-lld \
  'touch src/main.rs && CARGO_TARGET_DIR=target/clif $cg_clif_dir/build/cargo.sh build' \
  -n clif-with-lld \
  'touch src/main.rs && CARGO_TARGET_DIR=target/clif_lld RUSTFLAGS="-C link-arg=-fuse-ld=lld" $cg_clif_dir/build/cargo.sh build'
