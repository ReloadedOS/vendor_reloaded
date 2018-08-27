# Set SDClang defaults
export SDCLANG=false
export SDCLANG_PATH=vendor/qcom/sdclang-6.0/linux-x86/bin
export SDCLANG_LTO_DEFS=vendor/wave/sdclang/sdllvm-lto-defs.mk
export SDCLANG_COMMON_FLAGS="-O3 -fvectorize -Wno-user-defined-warnings -Wno-vectorizer-no-neon \
-Wno-unknown-warning-option -Wno-deprecated-register -Wno-tautological-type-limit-compare \
-Wno-sign-compare -Wno-gnu-folding-constant -mllvm -arm-implicit-it=always -Wno-inline-asm \
-Wno-unused-command-line-argument -Wno-unused-parameter -Wno-sometimes-uninitialized \
-Wno-shorten-64-to-32 -Wno-unused-variable -Wno-unused-function -g0 -DNDEBUG"

# Enable based on host OS/availablitiy
if [[ $(uname -s) == "Linux" ]]; then export SDCLANG=true; fi
