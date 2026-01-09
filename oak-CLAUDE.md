# `oak` machine info

Headless Arch desktop. You have full access to administer this machine. User accesses remotely (SSH from phone/laptop). Physical access possible but avoid if possible.

Stack: zsh, ghostty, hyprland, waybar, yay

Dotfiles at `~/.dotfiles` (uses dotbot). Oak-specific config in `oak.conf.yaml`.

We have a variety of custom utilities built to simplify administration. You can find them in `~/code/oak-utils`.

## Telegram notifications (tg CLI)
- Use `tg` to send notifications to the user via Telegram
- Commands:
  - `tg <message>` - send a message
  - `tg ask <message>` - send and wait for text reply (10 min timeout)
  - `tg confirm <message>` - send with Approve/Deny buttons, returns "approved" or "denied"
  - `tg image <path> [caption]` - send an image with optional caption
  - `tg file <path> [caption]` - send a file with optional caption
- Config is at `~/.config/tg/config.json`

