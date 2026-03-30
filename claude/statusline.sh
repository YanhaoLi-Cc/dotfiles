#!/bin/bash
# Claude Code Status Line - Multi-line with progress bar
DATA=$(cat 2>/dev/null) || { echo "⏳"; exit 0; }
[ -z "$DATA" ] && { echo "⏳"; exit 0; }

# Safe jq - use try/catch style
j() { echo "$DATA" | jq -r "try ($1) // empty" 2>/dev/null || echo "$2"; }

MODEL=$(j '.model.display_name' 'unknown')
CWD_FULL=$(j '.cwd' '')
CWD=$(basename "$CWD_FULL" 2>/dev/null || echo '?')
COST=$(j '.cost.total_cost_usd' '0')
DURATION_MS=$(j '.cost.total_duration_ms' '0')
LINES_ADDED=$(j '.cost.total_lines_added' '0')
LINES_REMOVED=$(j '.cost.total_lines_removed' '0')
CONTEXT_PCT=$(j '.context_window.used_percentage' '0')
CTX_MAX=$(j '.context_window.context_window_size' '200000')

CUR_INPUT=$(j '.context_window.current_usage.input_tokens' '0')
CUR_OUTPUT=$(j '.context_window.current_usage.output_tokens' '0')
CUR_CACHE_C=$(j '.context_window.current_usage.cache_creation_input_tokens' '0')
CUR_CACHE_R=$(j '.context_window.current_usage.cache_read_input_tokens' '0')
CUR_TOTAL=$(( ${CUR_INPUT:-0} + ${CUR_OUTPUT:-0} + ${CUR_CACHE_C:-0} + ${CUR_CACHE_R:-0} ))

# Git branch (timeout 1s)
BRANCH=""
[ -n "$CWD_FULL" ] && BRANCH=$(timeout 1 git -C "$CWD_FULL" rev-parse --abbrev-ref HEAD 2>/dev/null || true)

# Helpers
fmt_k() { local n=${1:-0}; [ "${n:-0}" -ge 1000 ] 2>/dev/null && echo "$((n/1000))k" || echo "${n:-0}"; }

USED_FMT=$(fmt_k "$CUR_TOTAL")
MAX_FMT=$(fmt_k "$CTX_MAX")

DS=$(( ${DURATION_MS:-0} / 1000 ))
M=$((DS/60)); S=$((DS%60))
[ "$M" -gt 0 ] && DUR="${M}m ${S}s" || DUR="${S}s"

COST_FMT=$(printf "%.2f" "${COST:-0}" 2>/dev/null || echo "0.00")

# Progress bar
BW=16; PCT=${CONTEXT_PCT:-0}
F=$(( PCT * BW / 100 )); E=$((BW - F))
BAR=""; for((i=0;i<F;i++)); do BAR+="█"; done; for((i=0;i<E;i++)); do BAR+="░"; done

# Colors
T='\033[36m'; G='\033[32m'; R='\033[31m'; GY='\033[90m'; O='\033[33m'; Z='\033[0m'

# Line 1
L1="${T}[${MODEL}]${Z} 📂 ${CWD}"
[ -n "$BRANCH" ] && L1+=" ${GY}|${Z} 🌿 ${BRANCH}"

# Line 2
L2="${G}${BAR}${Z} ${PCT}% (${USED_FMT}/${MAX_FMT}) ${GY}|${Z} ${O}\$${COST_FMT}${Z} ${GY}|${Z} ⏱ ${DUR}"

# Line 3
L3=""
[ "${LINES_ADDED:-0}" != "0" ] || [ "${LINES_REMOVED:-0}" != "0" ] && L3="${G}+${LINES_ADDED}${Z} ${R}-${LINES_REMOVED}${Z}"

echo -e "$L1"
echo -e "$L2"
[ -n "$L3" ] && echo -e "$L3"
exit 0
