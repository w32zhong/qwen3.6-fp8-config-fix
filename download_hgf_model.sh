#!/usr/bin/env bash
set -euo pipefail

endpoint=${HF_ENDPOINT:-https://hf-mirror.com}
models_dir=${MODELS_DIR:-Models}

for model in \
	Qwen/Qwen3.6-27B-FP8 \
; do
	local_dir="$models_dir/$model"
	mkdir -p "$local_dir"
	HF_ENDPOINT="$endpoint" hf download "$model" --local-dir "$local_dir"
done
