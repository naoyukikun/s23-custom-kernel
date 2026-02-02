#!/usr/bin/env bash
set -euo pipefail

# (env-overridable)
KERNEL_DEFCONFIG=${KERNEL_DEFCONFIG:-gki_defconfig}
CLANG_VERSION=${CLANG_VERSION:-clang-r574158}
OUT_DIR=${OUT_DIR:-out}
CLANG_DIR=${CLANG_DIR:-"$HOME/tools/google-clang"}
CLANG_BINARY="$CLANG_DIR/bin/clang"
START_TIME=$(date +%s)

# --- pretty logs ---
GREEN='\033[0;32m'; YELLOW='\033[1;33m'; RED='\033[0;31m'; NC='\033[0m'
info(){ echo -e "${GREEN}[INFO]${NC} $*"; }
warn(){ echo -e "${YELLOW}[WARN]${NC} $*"; }
err(){  echo -e "${RED}[ERROR]${NC} $*"; exit 1; }

setup_clang() {
  info "Setting up Neutron Clang..."
  
  # Define directory for Neutron
  CLANG_DIR="$HOME/tools/neutron-clang"
  
  # Only download if not already present
  if [ ! -f "$CLANG_DIR/bin/clang" ]; then
    mkdir -p "$CLANG_DIR"
    cd "$CLANG_DIR"
    
    # Use Antman (Neutron's downloader) to fetch the optimized compiler
    curl -LO "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman"
    chmod +x antman
    ./antman -S
    
    # Patch for some systems (glibc compatibility)
    ./antman --patch=glibc
    
    cd -
  fi

  # update binary path
  CLANG_BINARY="$CLANG_DIR/bin/clang"
  export PATH="$CLANG_DIR/bin:$PATH"
  
  # Verify version
  ver="$("$CLANG_BINARY" --version | head -n1)"
  info "Using compiler: $ver"
}

build_kernel() {
  info "Starting kernel build..."
  setup_clang
  mkdir -p "$OUT_DIR"

  # 1. CONFIGURATION STEP (Standard)
  make -j"$(nproc --all)" O="$OUT_DIR" ARCH=arm64 CC=clang LD=ld.lld LLVM=1 LLVM_IAS=1 \
       "$KERNEL_DEFCONFIG" || err "defconfig failed"

  # 2. BUILD STEP (The Fix)
  # - KCFLAGS="-w": Silences warnings so Neutron Clang 19 doesn't crash the build
  # - Removed "Image.gz": Now builds EVERYTHING (Modules + DTBs + Image)
  make -j"$(nproc --all)" \
      O="$OUT_DIR" \
      ARCH=arm64 \
      CC=clang \
      LD=ld.lld \
      LLVM=1 \
      LLVM_IAS=1 \
      CROSS_COMPILE=aarch64-linux-gnu- \
      CROSS_COMPILE_COMPAT=arm-linux-gnueabi- \
      KCFLAGS="-w -mllvm -polly" \
      CONFIG_WERROR=n || err "build failed"

  total=$(( $(date +%s) - START_TIME ))
  info "Build finished in $((total/60))m $((total%60))s."
}

# Always build
build_kernel
