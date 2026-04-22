#!/usr/bin/env bash
# Claude Code status line script

input=$(cat)

# -- Line 1: current folder + git prompt --
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
if [ -z "$cwd" ]; then
  cwd=$(pwd)
fi

# Shorten path: replace $HOME with ~
home="$HOME"
short_cwd="${cwd/#$home/~}"

# Build git status segment
git_segment=""
git_raw=$(GIT_OPTIONAL_LOCKS=0 git -C "$cwd" status --branch --porcelain=v2 2>/dev/null)
if [ -n "$git_raw" ]; then
  head=$(echo "$git_raw" | awk '$2=="branch.head"{print $3}')
  oid=$(echo "$git_raw" | awk '$2=="branch.oid"{print substr($3,1,7)}')
  ab=$(echo "$git_raw" | awk '$2=="branch.ab"{print $3, $4}')
  ahead=$(echo "$ab" | awk '{print $1+0}')
  behind=$(echo "$ab" | awk '{print $2+0}')

  staged=0; unstaged=0; untracked=0; unmerged=0
  while IFS= read -r line; do
    marker="${line:0:1}"
    if [ "$marker" = "?" ]; then
      untracked=$((untracked + 1))
    elif [ "$marker" = "u" ]; then
      unmerged=$((unmerged + 1))
    elif [ "$marker" = "1" ] || [ "$marker" = "2" ]; then
      xy="${line:2:2}"
      x="${xy:0:1}"; y="${xy:1:1}"
      [ "$x" != "." ] && staged=$((staged + 1))
      [ "$y" != "." ] && unstaged=$((unstaged + 1))
    fi
  done <<< "$git_raw"

  # Branch or detached
  if [ "$head" = "(detached)" ]; then
    branch_part="$(printf '\033[1;36m:%s\033[0m' "$oid")"
  else
    branch_part="$(printf '\033[1;35m%s\033[0m' "$head")"
  fi

  # Ahead/behind
  track_part=""
  [ "$behind" -lt 0 ] 2>/dev/null && track_part="${track_part}$(printf '\033[0m↓%s' $(( behind * -1 )))"
  [ "$ahead" -gt 0 ] 2>/dev/null && track_part="${track_part}$(printf '\033[0m↑%s' "$ahead")"

  # Status indicators
  status_part=""
  [ "$unmerged" -gt 0 ]  && status_part="${status_part}$(printf '\033[0;31m✖%s\033[0m' "$unmerged")"
  [ "$staged" -gt 0 ]    && status_part="${status_part}$(printf '\033[0;32m●%s\033[0m' "$staged")"
  [ "$unstaged" -gt 0 ]  && status_part="${status_part}$(printf '\033[0;31m✚%s\033[0m' "$unstaged")"
  [ "$untracked" -gt 0 ] && status_part="${status_part}$(printf '\033[0m…%s\033[0m' "$untracked")"
  if [ "$unmerged" -eq 0 ] && [ "$staged" -eq 0 ] && [ "$unstaged" -eq 0 ] && [ "$untracked" -eq 0 ]; then
    status_part="$(printf '\033[1;32m✔\033[0m')"
  fi

  git_segment=" $(printf '\033[0m[')${branch_part}${track_part}$(printf '\033[0m|')${status_part}$(printf '\033[0m] ')"
fi

# Extract Shortcut ticket from branch name (e.g. sc-68311)
ticket_part=""
if [ -n "$head" ] && [ "$head" != "(detached)" ]; then
  ticket=$(echo "$head" | sed -n 's/.*\(sc-[0-9][0-9]*\).*/\1/p')
  if [ -n "$ticket" ]; then
    ticket_part="$(printf ' \033[1;34m[%s]\033[0m' "$ticket")"
  fi
fi

# Build line 1
line1="${short_cwd}${git_segment}${ticket_part}"

# -- Model --
model=$(echo "$input" | jq -r '.model.display_name // "Unknown"')

# -- Context window --
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# -- Rate limits --
five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_resets_at=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
week_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
week_resets_at=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

# Build unicode progress bar (10 chars wide)
# Uses █ (full) / ▄ (partial) / ░ (empty) — ykdojo thresholds
make_bar() {
  local pct="${1:-0}"
  local width="${2:-10}"
  local bar=""
  for ((i=0; i<width; i++)); do
    local bar_start=$(( i * 10 ))
    local progress=$(( pct - bar_start ))
    if [[ $progress -ge 8 ]]; then
      bar+="█"
    elif [[ $progress -ge 3 ]]; then
      bar+="▒"
    else
      bar+="░"
    fi
  done
  printf "%s" "$bar"
}

# -- Assemble parts --
parts=()

# Model name
parts+=("$(printf '\033[1;36m%s\033[0m' "$model")")

# Elapsed session time
transcript_path=$(echo "$input" | jq -r '.transcript_path // empty')
if [ -n "$transcript_path" ] && [ -f "$transcript_path" ]; then
  started_at=$(stat -f %B "$transcript_path" 2>/dev/null)
  if [ -n "$started_at" ] && [ "$started_at" -gt 0 ] 2>/dev/null; then
    now=$(date +%s)
    elapsed=$(( now - started_at ))
    if [ "$elapsed" -lt 3600 ]; then
      elapsed_str="$(( elapsed / 60 ))m"
    else
      elapsed_str="$(( elapsed / 3600 ))h $(( (elapsed % 3600) / 60 ))m"
    fi
    parts+=("$(printf '\033[0;37m%s\033[0m' "$elapsed_str")")
  fi
fi

# Context bar
if [ -n "$used_pct" ]; then
  bar=$(make_bar "$used_pct" 10)
  rounded=$(printf "%.0f" "$used_pct")
  parts+=("$(printf '\033[0;33mctx [%s] %s%%\033[0m' "$bar" "$rounded")")
fi

# 5-hour limit bar
if [ -n "$five_pct" ]; then
  bar=$(make_bar "$five_pct" 10)
  rounded=$(printf "%.0f" "$five_pct")
  five_reset_str=""
  if [ -n "$five_resets_at" ]; then
    five_reset_str="$(date -d "@$five_resets_at" '+%H:%M' 2>/dev/null)"
  fi
  parts+=("$(printf '\033[0;32m5h [%s] %s%% (%s)\033[0m' "$bar" "$rounded" "$five_reset_str")")
fi

# 7-day limit bar
if [ -n "$week_pct" ]; then
  bar=$(make_bar "$week_pct" 10)
  rounded=$(printf "%.0f" "$week_pct")
  week_reset_str=""
  if [ -n "$week_resets_at" ]; then
    week_reset_str="$(date -d "@$week_resets_at" '+%a %b %d %H:%M' 2>/dev/null)"
  fi
  parts+=("$(printf '\033[1;34m7d [%s] %s%% (%s)\033[0m' "$bar" "$rounded" "$week_reset_str")")
fi

# Join with dim pipe separators
result=""
for part in "${parts[@]}"; do
  if [ -z "$result" ]; then
    result="$part"
  else
    result="$result $(printf '\033[2m|\033[0m') $part"
  fi
done


printf "%s\n%s" "$line1" "$result"
