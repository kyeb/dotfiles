#!/usr/bin/env bash

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name')
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
user_host="$(whoami)@$(hostname -s)"
dir=$(basename "$cwd")
git_branch=$(git --no-optional-locks -C "$cwd" branch --show-current 2>/dev/null)

# Extract context window information
context_size=$(echo "$input" | jq -r '.context_window.context_window_size')
usage=$(echo "$input" | jq '.context_window.current_usage')

# Calculate current context usage percentage (not cumulative)
if [ "$usage" != "null" ]; then
    current_input=$(echo "$usage" | jq '.input_tokens')
    cache_creation=$(echo "$usage" | jq '.cache_creation_input_tokens')
    cache_read=$(echo "$usage" | jq '.cache_read_input_tokens')
    current_used=$((current_input + cache_creation + cache_read))
    usage_percent=$((current_used * 100 / context_size))
else
    usage_percent=0
fi

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

# Branch info in magenta (if it exists)
if [ -n "$git_branch" ]; then
    branch_colored="$(printf ' \033[2;35m%s\033[22m' "$git_branch")"
else
    branch_colored=""
fi

# Model in dim white
model_colored="$(printf '\033[2m[%s]\033[22m' "$model")"

# Context window usage with color based on percentage
if [ "$usage_percent" -lt 50 ]; then
    ctx_color=32  # green
elif [ "$usage_percent" -lt 80 ]; then
    ctx_color=33  # yellow
else
    ctx_color=31  # red
fi
context_colored="$(printf '\033[2;%sm[%d%%]\033[22m' "$ctx_color" "$usage_percent")"

# Combine everything
printf '%s %s%s %s %s' "$rainbow_text" "$dir_colored" "$branch_colored" "$model_colored" "$context_colored"
