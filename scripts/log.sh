#!/usr/bin/env bash
# Usage: ./scripts/log.sh "<topic>" <num_problems> "<what I learned>"
# Example: ./scripts/log.sh "arrays" 2 "prefix sums"
# Appends to daily-log.md, updates streak in README, commits and pushes.
set -e
cd "$(cd "$(dirname "$0")/.." && pwd)"
TOPIC="${1:?topic}"; COUNT="${2:?number of problems}"; LEARNED="${3:-}"
TODAY=$(date +%F)

echo "$TODAY | $TOPIC | $COUNT solved | $LEARNED" >> daily-log.md

prev_day() {
  date -d "$1 -1 day" +%F 2>/dev/null || date -j -v-1d -f %F "$1" +%F
}

dates=$(grep -oE '^[0-9]{4}-[0-9]{2}-[0-9]{2}' daily-log.md | sort -u)
streak=0
d="$TODAY"
while echo "$dates" | grep -qx "$d"; do
  streak=$((streak+1))
  d=$(prev_day "$d")
done
total=$(echo "$dates" | wc -l | tr -d ' ')

python3 - "$streak" "$total" "$TODAY" <<'PY'
import re, sys
streak, total, today = sys.argv[1:4]
p = "README.md"
s = open(p, encoding="utf-8").read()
block = ("<!-- STATS:START -->\n"
         f"🔥 **Current streak:** {streak} day(s)  \n"
         f"📅 **Days logged:** {total}  \n"
         f"🕒 **Last update:** {today}\n"
         "<!-- STATS:END -->")
s = re.sub(r"<!-- STATS:START -->.*?<!-- STATS:END -->", block, s, flags=re.S)
open(p, "w", encoding="utf-8").write(s)
PY

git add -A
git commit -m "$TODAY: $TOPIC - $COUNT solved${LEARNED:+, $LEARNED}"
git push
echo "Logged and pushed. Streak: $streak"
