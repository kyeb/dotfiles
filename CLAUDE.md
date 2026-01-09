# CLAUDE.md

## Overview

Personal dotfiles for macOS (work) and Arch Linux (home). Uses [Dotbot](https://github.com/anishathalye/dotbot) for installation.

## Commands

```bash
./install              # Install dotfiles (runs dotbot with .install.conf.yaml)
```

Machine-specific configs are auto-loaded based on hostname (e.g., `oak.conf.yaml` for the `oak` machine).

## Structure

- `.install.conf.yaml` - Main dotbot config (symlinks, shell commands)
- `{hostname}.conf.yaml` - Machine-specific dotbot configs
- `.claude/CLAUDE.md` - User-level Claude Code instructions (symlinked to `~/.claude/CLAUDE.md`)
