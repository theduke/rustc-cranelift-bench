#! /usr/bin/env bash

set -euxo pipefail

if [[ ! -f $cg_clif_dir/build/cargo.sh ]]; then
    echo '$cg_clif_dir env var not set';
    exit 1
fi

echo "llvm without lld"
hyperfine -w 5 'touch src/main.rs && CARGO_TARGET_DIR=target/llvm cargo build'

echo "llvm with lld"
hyperfine -w 5 'touch src/main.rs && CARGO_TARGET_DIR=target/llvm_lld RUSTFLAGS="-C link-arg=-fuse-ld=lld" cargo build'

echo "clif without lld"
hyperfine -w 5 'touch src/main.rs && CARGO_TARGET_DIR=target/clif $cg_clif_dir/build/cargo.sh build'

echo "clif with lld"
hyperfine -w 5 'touch src/main.rs && CARGO_TARGET_DIR=target/clif_lld RUSTFLAGS="-C link-arg=-fuse-ld=lld" $cg_clif_dir/build/cargo.sh build'

