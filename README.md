# Dotfiles

A sophisticated dotfiles management system for macOS and Linux, featuring a modular shell initialization system with automatic symlinking, tool detection, and extensive customization.

![Shell Prompt](https://img.shields.io/badge/prompt-oh--my--posh-blue)
![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-green)
![Shell](https://img.shields.io/badge/shell-zsh%20%7C%20bash-orange)

## Features

- 🚀 **Modular Architecture**: Each tool has its own directory with automatic loading
- 🎨 **Beautiful Prompt**: Oh My Posh powerline theme with Git integration
- 🔧 **Smart Installation Detection**: Only loads configurations for installed tools
- 🔗 **Automatic Symlinking**: Bootstrap system creates all necessary symlinks
- 🌍 **Cross-Platform**: Works on macOS and Linux with platform-specific optimizations
- 📦 **Rich Toolset**: 30+ custom scripts and extensive tool integrations

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/sveinhal/dotfiles.git ~/.dotfiles

# Run bootstrap to create symlinks
~/.dotfiles/script/bootstrap

# Reload your shell
source ~/.zshrc  # or ~/.bashrc
```

### Requirements

- **Zsh** or **Bash** shell
- **Git** for repository management
- **Oh My Posh** for prompt theming (optional but recommended)

## Visual Appearance

The shell prompt uses Oh My Posh with a custom powerline theme displaying:

```
[username] [hostname] [SSH] [🏠] [path] [git-branch] [git-status] [exit-code]
```

### Color Indicators

- **Username**: Gray (normal) / Red (root)
- **SSH**: Orange badge when in SSH session
- **Home**: Green house icon when in home directory
- **Git Clean**: Green branch name
- **Git Dirty**: Orange branch with modifications
- **Git Ahead/Behind**: Red branch status
- **Errors**: Red exit codes for failed commands

## Directory Structure

```
~/.dotfiles/
├── 000.start/          # Early initialization (Homebrew, core paths)
├── bin/                # Custom scripts and utilities
├── system/             # System-wide settings and late initialization
├── script/             # Setup and maintenance scripts
│   └── bootstrap       # Main setup script
└── [tool]/             # Tool-specific configurations
    ├── dot.*           # Config files (symlinked to ~)
    ├── alias.sh        # Tool-specific aliases
    ├── path.sh         # PATH modifications
    └── load.sh         # Initialization logic
```

## Core Components

### Shell Initialization

The system automatically sources configuration files based on shell type:

- **Zsh**: Sources all `*.sh` and `*.zsh` files
- **Bash**: Sources all `*.sh` and `*.bash` files
- Files are sorted numerically (use prefixes like `000-` for ordering)

### Bootstrap System

The bootstrap script (`script/bootstrap`) automatically:
1. Finds all `dot.*` files in the repository
2. Creates symlinks in your home directory
3. Preserves existing non-symlink files for safety
4. Reports any conflicts or issues

### Tool Management

Each tool directory can contain:
- `dot.*` files: Symlinked to home directory (e.g., `dot.gitconfig` → `~/.gitconfig`)
- `*.sh`/`*.zsh` files: Auto-sourced during shell startup
- Executable scripts: Tool-specific utilities (no `.sh` extension)

## Integrated Tools

### Development Tools

| Tool | Description | Configuration |
|------|-------------|--------------|
| **Git** | Version control with Hub integration | GPG signing, difftastic, custom aliases |
| **Mise** | Modern version manager | Replaces nvm, pyenv, rbenv |
| **Go** | Go language support | Project-specific path overrides |
| **Python** | Python environment management | Custom manager script |
| **GPG** | Cryptographic signing | Commit signing configuration |

### Shell Enhancements

| Tool | Description | Features |
|------|-------------|----------|
| **Oh My Posh** | Prompt theming engine | Custom powerline theme |
| **Zoxide** | Smart directory navigation | AI-powered cd replacement |
| **GRC** | Generic colorizer | Colorizes Unix tools output |
| **tmux** | Terminal multiplexer | SSH integration, detach-on-ctrl-d |

### System Integration

| Component | Description | Features |
|-----------|-------------|----------|
| **SSH** | Secure shell configuration | Proxy commands, agent forwarding |
| **Tailscale** | Mesh VPN configuration | Network shortcuts |
| **macOS** | Platform-specific settings | Homebrew integration |

## Custom Scripts

The `bin/` directory contains 30+ utilities. See [docs/scripts.md](docs/scripts.md) for full documentation.

### Highlights

- **Git utilities**: `git-delete-squashed`, `git-promote`, `git-rank-contributers`
- **System tools**: `colors` (256-color palette), `battery`, `notes`
- **Development**: `python-manager`, `diffmerge`, `headers`

## Configuration Details

For detailed information about specific components:

- [Shell Prompt Configuration](docs/prompt.md)
- [Tool Configurations](docs/tools.md)
- [Custom Scripts Reference](docs/scripts.md)
- [Troubleshooting Guide](docs/troubleshooting.md)

## Adding New Tools

### Quick Guide

```bash
# 1. Create tool directory
mkdir ~/.dotfiles/newtool

# 2. Add configuration file (optional)
echo "config" > ~/.dotfiles/newtool/dot.newtoolrc

# 3. Create initialization script
cat > ~/.dotfiles/newtool/load.sh << 'EOF'
#!/usr/bin/env bash
if command -v newtool &> /dev/null; then
    export NEWTOOL_HOME="$HOME/.newtool"
    export PATH="$NEWTOOL_HOME/bin:$PATH"
fi
EOF

# 4. Run bootstrap
~/.dotfiles/script/bootstrap
```

See [CLAUDE.md](CLAUDE.md) for comprehensive development guidelines.

## License

This dotfiles configuration is personal and provided as-is for reference and inspiration.

## Author

Svein Halvor Halvorsen
