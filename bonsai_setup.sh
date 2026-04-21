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

case "$MODEL_SIZE" in
  1.7B)
    MODEL_FILE="Bonsai-1.7B.gguf"
    ;;
  4B)
    MODEL_FILE="Bonsai-4B.gguf"
    ;;
  8B)
    MODEL_FILE="Bonsai-8B.gguf"
    ;;
esac

if find . -name "$MODEL_FILE" | grep -q .; then
  echo "$MODEL_FILE はすでに存在するため、setup.sh をスキップします。"
else
  echo "$MODEL_FILE が見つからないため、setup.sh を実行します。"
  ./setup.sh
fi

scripts/start_llama_server.sh