## Fixing local SGL + QWen3.6-fp8 running
HuggingFace model version: https://huggingface.co/Qwen/Qwen3.6-27B-FP8/commit/c79abb8dddf284f31fd5a44fed917f261c72948b

Local GPUs: 4 x `RTX 4070 TiS`

```sh
docker run -it --gpus all --ipc=host \
        -p 30000:30000 \
        -v `pwd`:/mnt \
        lmsysorg/sglang:v0.5.10.post1-cu130 \
        python3 -m sglang.launch_server \
                --host 0.0.0.0 --port 30000 \
                --tp 4 --mem-fraction-static 0.7 \
                --cuda-graph-max-bs 2 \
                --prefill-max-requests 1 \
                --chunked-prefill-size 1024 \
                --model-path /mnt/Models/Qwen/Qwen3.6-27B-FP8 \
                --reasoning-parser qwen3 \
                --tool-call-parser qwen3_coder \
                --quantization fp8 \
                --kv-cache-dtype fp8_e4m3 \
                --context-length 41000 \
                --allow-auto-truncate \
                --disable-fast-image-processor \
                --mm-max-concurrent-calls 1 \
                --mm-process-config '{"image":{"max_pixels":40000}}'
```
