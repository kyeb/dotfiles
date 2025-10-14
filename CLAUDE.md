# kyeb user-level CLAUDE.md

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

## Committing
IF and ONLY IF I ask you to commit or push your changes, then:
- Use `gt add "<filename1> <filename2>"` to add all the files you modified
- Use `gt status` to check for what is added or not.
  - There may be unrelated changes. That's ok, ignore any unrelated changes - only add the changes you made.
  - Before proceeding, make sure only the files relevant to the current request are staged.
  - Before proceeding, make sure ALL the files you modified as part of the current request are staged.
- Use `gt c -m "commit message"` to create a new branch/commit with your changes via Graphite
- Graphite handles stacking well, so you may create multiple changes with `gt` and submit them once as a stack if they are indepdendent and can/should be reviewed independently
- If you are making a fix or subsequent tweak to an existing change, just use `gt m` to modify the existing branch, instead of creating a new branch/commit every time.
- Use `gt ss` to submit the stack of changes!
- When modifying a commit/branch with `gt`, make sure to `gt add` any files changed before running `gt m` to modify the branch/commit.

