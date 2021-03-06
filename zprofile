# Load ssh-agent (source: wiki.archlinux.org/index.php/SSH_keys)
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        ssh-agent > "/tmp/ssh-agent.env"
fi
if [[ ! "$SSH_AUTH_SOCK" ]]; then
        eval "$(<"/tmp/ssh-agent.env")" > /dev/null
fi

# Cleaning up home directory woohoo
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android

