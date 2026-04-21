#!/usr/bin/env bash
set -e

cd /workspaces/dev_system_test/Bonsai-demo
source .venv/bin/activate

while true; do
  echo "起動するモデルサイズを選んでください: 1.7B / 4B / 8B"
  echo "終了する場合は q を入力してください"
  read -r MODEL_SIZE

  case "$MODEL_SIZE" in
    1.7B)
      MODEL_FILE="Bonsai-1.7B.gguf"
      break
      ;;
    4B)
      MODEL_FILE="Bonsai-4B.gguf"
      break
      ;;
    8B)
      MODEL_FILE="Bonsai-8B.gguf"
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

if ! find . -name "$MODEL_FILE" | grep -q .; then
  echo "$MODEL_FILE が見つかりません。先に setup_bonsai.sh でインストールしてください。"
  exit 1
fi

MODEL_PATH="$(find "$(pwd)" -name "$MODEL_FILE" | head -n 1)"

./bin/cpu/llama-server -m "$MODEL_PATH" -c 0

scripts/start_llama_server.sh