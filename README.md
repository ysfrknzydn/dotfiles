# dotfiles

Personal configuration files and Claude Code settings.

## Structure

```
dotfiles/
├── claude/
│   ├── CLAUDE.md         # Global Claude Code instructions — symlink to ~/.claude/CLAUDE.md
│   ├── settings.json     # Global Claude Code permissions — symlink to ~/.claude/settings.json
│   └── skills/           # Claude Code skills — symlink to ~/.claude/skills
│       └── <skill-name>/SKILL.md
├── zsh/
│   ├── .zshrc            # symlink to ~/.zshrc
│   └── .zprofile         # symlink to ~/.zprofile
├── git/
│   └── .gitconfig        # symlink to ~/.gitconfig
└── README.md
```

## New machine setup

```bash
git clone https://github.com/ysfrknzydn/dotfiles.git ~/dotfiles
```

Then symlink each file individually (not whole directories at the `~/.claude` level,
so Claude Code can still write its own machine-local files like `projects/` and
`todos/` into `~/.claude` without them ending up in this repo):

```bash
mkdir -p ~/.claude
ln -s ~/dotfiles/claude/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/dotfiles/claude/settings.json ~/.claude/settings.json
ln -s ~/dotfiles/claude/skills ~/.claude/skills

ln -s ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s ~/dotfiles/zsh/.zprofile ~/.zprofile
ln -s ~/dotfiles/git/.gitconfig ~/.gitconfig
```

Verify with `ls -la ~/.zshrc ~/.claude/CLAUDE.md` etc. — each should show `->`
pointing back into `~/dotfiles/`.

## Adding a new skill

1. `mkdir -p ~/dotfiles/claude/skills/<skill-name>`
2. Write `SKILL.md` inside it with frontmatter:
   ```yaml
   ---
   name: <skill-name>
   description: What this does and when Claude should use it.
   ---
   ```
   followed by markdown instructions for Claude to follow.
3. Because `~/.claude/skills` is symlinked to this repo, Claude picks it up
   immediately — no restart needed.
4. Commit and push so it's available on other machines.

## Keeping this repo up to date

- Whenever you tweak `~/.zshrc`, `~/.gitconfig`, Claude settings, or a skill, you're
  actually editing the real file here in `~/dotfiles` (the stuff in `~` is just a
  symlink) — so changes are already "in" the repo.
- Periodically `cd ~/dotfiles && git status` to see what's changed, then commit.
- On a new machine, clone + re-run the symlink commands above and everything is back.

## Credits

The `markitdown` skill and the overall symlink-based layout were adapted from
[jhelvy/dotfiles](https://github.com/jhelvy/dotfiles) as a learning reference.
