#!/bin/bash

# 关闭 controller 进程
controller_pid=$(ps aux | grep "python -m llava.serve.controller" | grep -v grep | awk '{print $2}')
if [ -n "$controller_pid" ]; then
    kill $controller_pid
fi

# 关闭 gradio_web_server 进程
gradio_pid=$(ps aux | grep "python -m llava.serve.gradio_web_server" | grep -v grep | awk '{print $2}')
if [ -n "$gradio_pid" ]; then
    kill $gradio_pid
fi

# 关闭 model_worker 进程
model_worker_pid=$(ps aux | grep "python -m llava.serve.model_worker" | grep -v grep | awk '{print $2}')
if [ -n "$model_worker_pid" ]; then
    kill $model_worker_pid
fi