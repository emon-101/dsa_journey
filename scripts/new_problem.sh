#!/usr/bin/env bash
# Usage: ./scripts/new_problem.sh <topic-folder> <problem_name>
# Example: ./scripts/new_problem.sh 02-arrays-and-strings two_sum
set -e
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TOPIC="$1"; NAME="$2"
if [ -z "$TOPIC" ] || [ -z "$NAME" ]; then
  echo "Usage: $0 <topic-folder> <problem_name>"; echo "Topics:"
  for d in "$ROOT"/[0-9]*/; do basename "$d"; done
  exit 1
fi
DIR="$ROOT/$TOPIC"
[ -d "$DIR" ] || { echo "Topic folder not found: $TOPIC"; exit 1; }
FILE="$DIR/$NAME.cpp"
[ -e "$FILE" ] && { echo "Already exists: $FILE"; exit 1; }
sed "s/<YYYY-MM-DD>/$(date +%F)/; s/<name>/$NAME/" "$ROOT/templates/problem_template.cpp" > "$FILE"
echo "Created $FILE"
