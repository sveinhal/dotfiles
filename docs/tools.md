# Tool Configurations

This document provides detailed information about each tool integration in the dotfiles repository.

## Git

### Configuration Files
- `git/dot.gitconfig`: Main git configuration
- `git/dot.gitignore_global`: Global gitignore patterns
- `git/alias.sh`: Shell aliases for git commands
- `git/git.zsh`: Zsh-specific git configuration

### Key Features

#### Aliases
Common git aliases configured:
- `glog`: Pretty formatted log with graph
- `changelog`: Generate changelog between tags
- `hub`: GitHub CLI integration (aliased to git)

#### Tools Integration
- **GPG Signing**: Automatic commit signing with GPG key
- **Difftastic**: Semantic diff tool for better code diffs
- **Delta**: Syntax-highlighted pager for git diff
- **Hub**: GitHub integration for pull requests and issues

#### Configuration Highlights
```gitconfig
[user]
    signingkey = <GPG_KEY>
[commit]
    gpgsign = true
[diff]
    tool = difftastic
[merge]
    conflictstyle = diff3
```

## Oh My Posh

### Configuration Files
- `oh-my-posh/custom-powerline.json`: Custom theme definition
- `oh-my-posh/init.zsh`: Initialization script

### Setup
The prompt is initialized with:
```bash
eval "$(oh-my-posh init zsh --config ~/.dotfiles/oh-my-posh/custom-powerline.json)"
```

### Features
- Powerline-style segmented prompt
- Git repository status integration
- SSH session detection
- Exit code visualization
- Directory write permission indicator

## Mise (formerly rtx)

### Configuration Files
- `mise/load.sh`: Mise initialization and setup
- `mise/dot.config/mise/config.toml`: Global mise configuration

### Purpose
Mise is a polyglot runtime manager that replaces:
- nvm (Node.js)
- rbenv (Ruby)
- pyenv (Python)
- goenv (Go)

### Usage
```bash
# Install a tool
mise install node@latest

# Use a specific version
mise use node@18

# List installed versions
mise list
```

## Zoxide

### Configuration Files
- `zoxide/load.sh`: Zoxide initialization

### Features
- Smart directory jumping based on frecency
- Learns from your navigation patterns
- Replaces traditional `cd` command

### Usage
```bash
# Jump to most frecent directory matching "proj"
z proj

# Interactive selection
zi proj
```

## SSH

### Configuration Files
- `ssh/dot.ssh/config`: SSH client configuration
- `ssh/origin-proxy`: ProxyCommand script for conditional routing
- `ssh/tmux-on-ssh.sh`: tmux integration for SSH sessions

### Features

#### Smart Proxy Routing
The `origin-proxy` script enables conditional ProxyCommand based on connection origin:
- Direct connection when on same network
- Proxy through jump host when remote

#### tmux Integration
Automatic tmux session management:
- Creates/attaches to tmux session on SSH login
- Preserves SSH agent forwarding across reconnections
- Updates environment variables in tmux

### Configuration Example
```ssh
Host myserver
    ProxyCommand ~/.dotfiles/ssh/origin-proxy jump.example.com %h %p
    ForwardAgent yes
```

## tmux

### Configuration Files
- `tmux/dot.tmux.conf`: tmux configuration
- `tmux/tmux-detach-on-ctrl-d.sh`: Smart detachment script

### Features
- Custom key bindings
- Status bar configuration
- Window/pane management shortcuts
- SSH agent forwarding persistence

### Key Bindings
- `Ctrl-b`: Prefix key (default)
- `Ctrl-d`: Smart detach (only in tmux)
- Standard window/pane navigation

## GPG

### Configuration Files
- `gpg/load.sh`: GPG agent initialization
- `gpg/gpg.zsh`: Zsh-specific GPG setup

### Features
- GPG agent management
- SSH key support through GPG agent
- Commit signing configuration
- Pinentry program setup

### Setup
```bash
# Import your GPG key
gpg --import private-key.asc

# Configure git to use GPG
git config --global user.signingkey YOUR_KEY_ID
git config --global commit.gpgsign true
```

## Python

### Configuration Files
- `python/python-manager`: Python version management script
- `python/path.sh`: Python path configuration

### Features
- Custom Python version management
- Virtual environment support
- Path configuration for Python tools

## Go

### Configuration Files
- `go/path.sh`: Go path configuration
- `go/load.sh`: Go environment setup

### Environment Variables
```bash
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
```

### Project Overrides
Supports project-specific GOPATH overrides for different Go projects.

## System Utilities

### GRC (Generic Colorizer)

#### Configuration Files
- `system/grc.zsh`: GRC aliases setup

#### Colorized Commands
Automatically colorizes output for:
- `ls`, `head`, `tail`
- `diff`, `make`, `gcc`
- `netstat`, `ping`, `traceroute`
- `ps`, `dig`, `mount`

### Tailscale

#### Configuration Files
- `tailscale/alias.sh`: Tailscale shortcuts

#### Features
- Quick access to Tailscale status
- Network shortcuts
- VPN management aliases

## Platform-Specific

### macOS (osx/)

#### Configuration Files
- `osx/path.sh`: macOS-specific paths
- `osx/alias.sh`: macOS-specific aliases

#### Features
- Homebrew integration
- macOS-specific utilities
- System preferences shortcuts

### Xcode

#### Configuration Files
- `xcode/alias.sh`: Xcode command shortcuts

#### Aliases
- Build shortcuts
- Simulator management
- Project cleaning utilities

## Shell Environments

### Zsh

#### Configuration Files
- `zsh/dot.zshrc`: Main Zsh configuration
- `zsh/config.zsh`: Zsh options and settings
- `zsh/functions/`: Custom Zsh functions
- `zsh/prompt.zsh`: Prompt configuration

#### Features
- Comprehensive completion system
- History management with shared history
- Key bindings for navigation
- Custom functions library

### Bash

#### Configuration Files
- `bash/dot.bashrc`: Main Bash configuration
- `bash/bash-completion.bash`: Completion setup

#### Features
- Bash completion support
- POSIX-compatible configurations
- Fallback for systems without Zsh

## AI Tools

### Configuration Files
- `ai/load.sh`: AI tool initialization

### Potential Integrations
- GitHub Copilot CLI
- OpenAI CLI tools
- Local LLM interfaces

## Development Workflow

### Best Practices for Tool Configuration

1. **Check Installation**: Always verify tool is installed
   ```bash
   if command -v tool &> /dev/null; then
       # Configure tool
   fi
   ```

2. **Lazy Loading**: For heavy tools, defer loading
   ```bash
   tool() {
       unset -f tool
       source /path/to/tool/init.sh
       tool "$@"
   }
   ```

3. **Platform Detection**: Handle different platforms
   ```bash
   if [[ "$(uname)" == "Darwin" ]]; then
       # macOS specific
   fi
   ```

## Adding New Tool Configurations

To add a new tool:

1. Create directory: `mkdir ~/.dotfiles/toolname`
2. Add configuration: `~/.dotfiles/toolname/dot.toolrc`
3. Create loader: `~/.dotfiles/toolname/load.sh`
4. Run bootstrap: `~/.dotfiles/script/bootstrap`

See the main [README.md](../README.md) for detailed instructions.