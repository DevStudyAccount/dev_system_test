#!/usr/bin/env bash
set -e

cd Bonsai-demo
source .venv/bin/activate
uv pip install openai
python3 ../interface.py