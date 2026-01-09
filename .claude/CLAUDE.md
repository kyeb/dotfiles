# kyeb user-level CLAUDE.md

## Package management
- Python: use `uv` for all dependency management
- Node.js: default to `pnpm` and `nodenv` unless the project uses something else

## Projects
- All new projects should be created in `~/code/`

## Code style
- Only add comments if they're necessary to explain a surprising or confusing piece of code. Normally, variable and function names should be enough to make the code readable without comments.
- When there are parentheses, quote the paths properly so that the shell doesn't try to interpret them.
- If you're working on a linear task, link it in the PR description by adding 'Fixes FAL-123' or 'Part of FAL-456'
- Prefer your Search tool, or use ripgrep to search for file contents
- When using ripgrep, use globs to filter by file type, e.g. `rg <term> -g '*.ts*'`
- Always use `fd` for finding specific file names or types

## Python
- Use `uv` for dependency management when possible.
- For one-off scripts, use  `uv` standalone script management
    - `uv init --script example.py` to initialize
    - `uv add --script example.py 'requests<3' 'rich'` to add dependencies
- Use `./falcon run scripts/my_script.py` to run scripts that self-describe their dependencies in the header using uv standalone

## Task management
- I ALWAYS use Linear for task management and issues. Use the `linctl` CLI to interact with Linear issues.
- Examples:
  - To get details for FAL-385, use: `linctl issue get FAL-385`
  - Run `linctl issue --help` or `linctl issue update --help` to see other commands

