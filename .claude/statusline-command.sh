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

# Branch info in magenta (if it exists)
if [ -n "$git_branch" ]; then
    branch_colored="$(printf ' \033[2;35m%s\033[22m' "$git_branch")"
else
    branch_colored=""
fi

# Model in dim white
model_colored="$(printf '\033[2m[%s]\033[22m' "$model")"

# Combine everything
printf '%s %s%s %s' "$rainbow_text" "$dir_colored" "$branch_colored" "$model_colored"
