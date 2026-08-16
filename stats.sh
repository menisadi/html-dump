#!/usr/bin/env bash
set -euo pipefail

BASE="https://menis-html-dump.goatcounter.com/api/v0/stats/total"
AUTH=(-H "Authorization: Bearer $GOATCOUNTER_DUMP")

week=$(curl -s "${AUTH[@]}" "$BASE")
all_time=$(curl -s "${AUTH[@]}" "$BASE?start=2020-01-01T00:00:00Z")

today=$(date -u +%Y-%m-%d)
today_count=$(jq -r --arg d "$today" '.stats[] | select(.day==$d) | .daily // 0' <<< "$week")

echo "All-time:  $(jq -r '.total' <<< "$all_time")"
echo "This week: $(jq -r '.total' <<< "$week")"
echo "Today:     ${today_count:-0}"
