# kyeb user-level CLAUDE.md

- Use the `gh` CLI to create pull requests (PRs) for changes that you push
- Only add comments if they're necessary to explain a surprising or confusing piece of code. Normally, variable and function names should be enough to make the code readable without comments.
- When there are parentheses, quote the paths properly so that the shell doesn't try to interpret them.
- If you're working on a linear task, link it in the PR description by adding 'Fixes FAL-123' or 'Part of FAL-456'
- Always use ripgrep, not grep. When using ripgrep, use globs to filter by file type, e.g. `rg <term> -g '*.ts*'`

## Python
- Use `uv` for dependency management when possible.
- For one-off scripts, use  `uv` standalone script management
    - `uv init --script example.py` to initialize
    - `uv add --script example.py 'requests<3' 'rich'` to add dependencies
- Use `./falcon run scripts/my_script.py` to run scripts that self-describe their dependencies in the header using uv standalone

## Committing
IF and ONLY IF I ask you to commit or push your changes, then:
- Use `gt add "<filename>"` to add each file you modified
- Use `gt status` to check for what is added or not.
  - There may be unrelated changes. That's ok, ignore any unrelated changes - only add the changes you made.
  - Before proceeding, make sure only the files relevant to the current request are staged.
- Use `gt c -m "commit message"` to create a new branch/commit with your changes via Graphite
- Graphite handles stacking well, so you may create multiple changes with `gt` and submit them once as a stack if they are indepdendent and can/should be reviewed independently
- Use `gt ss` to submit the stack of changes!