#!/usr/bin/env bash
set -e

while true; do
  echo "使うモデルサイズを選んでください: 1.7B / 4B / 8B"
  echo "終了する場合は q を入力してください"
  read -r MODEL_SIZE

  case "$MODEL_SIZE" in
    1.7B|4B|8B)
      break
      ;;
    q|quit|exit)
      echo "終了します"
      exit 0
      ;;
    *)
      echo "想定外の入力です。もう一度入力してください。"
      ;;
  esac
done

if [ ! -d Bonsai-demo ]; then
  git clone https://github.com/PrismML-Eng/Bonsai-demo.git
fi

cd Bonsai-demo

if [ ! -d .venv ]; then
  uv venv
fi

source .venv/bin/activate
uv pip install openai

export BONSAI_MODEL="$MODEL_SIZE"
./setup.sh

scripts/start_llama_server.sh