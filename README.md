# dotfiles

Personal configuration files.

## Structure

```
dotfiles/
├── install.sh              # One-command setup (symlinks everything)
├── claude/                 # Claude Code
│   ├── install.sh          # Claude-only installer
│   ├── settings.json
│   ├── statusline.sh       # Multi-line status bar with progress bar
│   └── commands/
│       └── report.md
├── tmux/                   # tmux (vim-style config)
│   ├── tmux.conf
│   └── README.md
├── zsh/                    # zsh (TODO)
└── git/                    # git (TODO)
```

## Install

```bash
git clone https://github.com/YanhaoLi-Cc/dotfiles.git
cd dotfiles

# Install everything
bash install.sh

# Or install only Claude Code config
bash claude/install.sh
```

## tmux

Vim-style tmux 配置，主要优化：

- Vi 键位导航和复制模式
- `prefix + \/-` 分屏，`prefix + hjkl` 切换面板
- `Alt+1~9` 快速切窗口
- escape-time 10ms、50000 行滚动、true color、One Dark 主题

详见 [tmux/README.md](tmux/README.md)。

## Claude Code Status Line

A multi-line status bar showing model, context usage, cost, and more:

```
[Opus 4.6] 📂 project | 🌿 main
████████░░░░░░░░ 50% (100k/200k) | $1.54 | ⏱ 19m 23s
+117 -27
```
