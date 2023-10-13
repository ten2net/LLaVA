#!/bin/bash

# conda create -n llava python=3.10 -y
# conda activate llava
# pip install --upgrade pip  # enable PEP 660 support
# pip install -e .

# activate conda env
source /root/miniconda3/etc/profile.d/conda.sh
conda activate cc-llava

# controller
nohup python -m llava.serve.controller --host 0.0.0.0 --port 10000 > controller.log 2>&1 &

# gradio_web_server
nohup python -m llava.serve.gradio_web_server --port 7861 --controller http://localhost:10000 --embed --model-list-mode reload > gradio_web_server.log 2>&1 &

# model_worker
export CUDA_VISIBLE_DEVICES=0 
nohup python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-name llava-v1.5-7b --model-path ../huggingface/liuhaotian/llava-v1.5-7b --load-4bit > model_worker.log 2>&1 &
# nohup CUDA_VISIBLE_DEVICES=0,1 python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-name llava-v1.5-7b --model-path ../huggingface/liuhaotian/llava-v1.5-7b --load-4bit > model_worker.log 2>&1 &




# python -m llava.serve.controller --host 0.0.0.0 --port 10000
# python -m llava.serve.gradio_web_server --port 7861 --controller http://localhost:10000 --embed --model-list-mode reload
# python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-name llava-v1.5-7b --model-path ../huggingface/liuhaotian/llava-v1.5-7b --load-4bit

# nohup python -m llava.serve.controller --host 0.0.0.0 --port 10000 > llava_controller.log &
# nohup python -m llava.serve.gradio_web_server --port 7861 --controller http://localhost:10000 --embed --model-list-mode reload > llava_gradio_web_server.log &
# nohup python -m llava.serve.model_worker --host 0.0.0.0 --controller http://localhost:10000 --port 40000 --worker http://localhost:40000 --model-name llava-v1.5-7b --model-path ../huggingface/liuhaotian/llava-v1.5-7b --load-4bit > llava_model_worker.log &