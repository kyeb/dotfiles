#!/usr/bin/env bash

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
user_host="$(whoami)@$(hostname -s)"
dir=$(basename "$cwd")
git_branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)

# Rainbow colors (will cycle through these)
rainbow_colors=(31 33 32 36 34 35)  # red, yellow, green, cyan, blue, magenta

# Apply rainbow to [user@host]
rainbow_text="["
text="${user_host}"
color_index=0
for (( i=0; i<${#text}; i++ )); do
    char="${text:$i:1}"
    color=${rainbow_colors[$color_index]}
    rainbow_text+="$(printf '\033[2;%sm%s' "$color" "$char")"
    color_index=$(( (color_index + 1) % ${#rainbow_colors[@]} ))
done
rainbow_text+="$(printf '\033[2;%sm]' "${rainbow_colors[$color_index]}")"

# Directory in cyan
dir_colored="$(printf '\033[2;36m%s\033[22m' "$dir")"

# Branch info in magenta (truncated to 30 chars)
if [ -n "$git_branch" ]; then
    if [ ${#git_branch} -gt 30 ]; then
        git_branch="${git_branch:0:29}…"
    fi
    branch_colored="$(printf ' \033[2;35m%s\033[22m' "$git_branch")"
else
    branch_colored=""
fi

# Model in dim white
model_colored="$(printf '\033[2m[%s]\033[22m' "$model")"

# Context window progress bar
# Sum current_usage fields to get actual token count (total_input_tokens excludes cached tokens).
# For 1M models, the effective window before autocompaction is ~400k.
ctx_size=$(echo "$input" | jq -r '.context_window.context_window_size // 0')
used_tokens=$(echo "$input" | jq '[.context_window.current_usage.input_tokens, .context_window.current_usage.cache_creation_input_tokens, .context_window.current_usage.cache_read_input_tokens] | map(. // 0) | add' 2>/dev/null)
if [ -n "$used_tokens" ] && [ "$used_tokens" -gt 0 ] 2>/dev/null; then
    effective_size="$ctx_size"
    [ "$ctx_size" -ge 1000000 ] && effective_size=400000
    used_int=$(( used_tokens * 100 / effective_size ))
    [ "$used_int" -gt 100 ] && used_int=100
    used_k="$(( used_tokens / 1000 )).$(( used_tokens % 1000 / 100 ))"
    bar_width=10
    filled=$(( (used_int * bar_width + 99) / 100 ))
    empty_blocks=$(( bar_width - filled ))
    bar=""
    for (( i=0; i<filled; i++ )); do bar+="█"; done
    for (( i=0; i<empty_blocks; i++ )); do bar+="░"; done
    if [ "$used_tokens" -lt 150000 ]; then
        bar_color="2"
    elif [ "$used_tokens" -lt 200000 ]; then
        bar_color="33"
    elif [ "$used_tokens" -lt 250000 ]; then
        bar_color="38;5;208"
    else
        bar_color="31"
    fi
    ctx_colored="$(printf '\033[2m[\033[22;%sm%s\033[0;2m]\033[0m \033[%sm%d%%\033[0m \033[2m(%sk)\033[0m' "$bar_color" "$bar" "$bar_color" "$used_int" "$used_k")"
else
    ctx_colored=""
fi

# Combine everything
printf '%s %s%s %s%s' "$rainbow_text" "$dir_colored" "$branch_colored" "$model_colored" "${ctx_colored:+ $ctx_colored}"
