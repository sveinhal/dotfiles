# Dotfiles Repository - Development Guide

## Repository Overview

This is a centralized dotfiles management system for macOS and Linux that provides:
- Automatic symlinking of configuration files
- Modular shell initialization system
- Tool-specific configuration with installation detection
- Cross-platform compatibility

## Architecture

### Core Components

1. **Bootstrap System** (`script/bootstrap`)
   - Finds all `dot.*` files and creates symlinks in home directory
   - Pattern: `~/.dotfiles/tool/dot.config` → `~/.config`
   - Preserves existing non-symlink files (safety feature)

2. **Shell Initialization**
   - **Bash**: Sources all `*.sh` and `*.bash` files via `.bashrc`
   - **Zsh**: Sources all `*.sh` and `*.zsh` files via `.zshrc`
   - Files are sorted numerically before sourcing (use prefixes like `000-` for ordering)
   - `bin/` directory automatically added to PATH

3. **Tool Organization**
   - Each tool gets its own directory
   - Standard file patterns:
     - `dot.*` - Configuration files to be symlinked
     - `*.sh`/`*.zsh` - Shell scripts to be sourced
     - `alias.sh` - Tool-specific aliases
     - `path.sh` - PATH modifications
     - `load.sh` - Lazy loading/initialization

## Directory Structure

```
.dotfiles/
├── 000.start/          # Early initialization (runs first)
├── bin/                # Executable scripts (added to PATH)
├── [tool]/             # Tool-specific directory
│   ├── dot.toolrc      # Config file (symlinked to ~/.toolrc)
│   ├── alias.sh        # Tool aliases
│   ├── path.sh         # PATH setup
│   └── load.sh         # Initialization logic
├── system/             # System-wide settings
│   └── 999.*.zsh       # Late initialization (runs last)
└── script/
    └── bootstrap       # Initial setup script
```

## Adding a New Tool

### Step 1: Create Tool Directory
```bash
mkdir ~/.dotfiles/newtool
```

### Step 2: Add Configuration File (if needed)
```bash
# Will be symlinked to ~/.newtoolrc
touch ~/.dotfiles/newtool/dot.newtoolrc
```

### Step 3: Create Initialization Script
```bash
cat > ~/.dotfiles/newtool/load.sh << 'EOF'
#!/usr/bin/env bash
# Tool initialization with installation check

if command -v newtool &> /dev/null; then
    # Tool is installed - set up environment
    export NEWTOOL_HOME="$HOME/.newtool"
    export PATH="$NEWTOOL_HOME/bin:$PATH"
    
    # Enable completions if available
    if [[ -n "$ZSH_VERSION" ]]; then
        eval "$(newtool completions zsh)"
    elif [[ -n "$BASH_VERSION" ]]; then
        eval "$(newtool completions bash)"
    fi
    
    # Tool-specific aliases
    alias nt='newtool'
else
    # Tool not installed - provide installation instructions
    echo "newtool not installed."
    if [[ "$(uname)" == "Darwin" ]]; then
        echo "Install with: brew install newtool"
    elif [[ -f /etc/debian_version ]]; then
        echo "Install with: apt-get install newtool"
    else
        echo "Visit: https://newtool.io/install"
    fi
fi
EOF
```

### Step 4: Run Bootstrap
```bash
~/.dotfiles/script/bootstrap
```

## Best Practices

### 1. Installation Detection Pattern
Always check if a tool is installed before configuring:
```bash
if command -v toolname &> /dev/null; then
    # Configuration here
else
    # Installation instructions
fi
```

### 2. Platform-Specific Logic
```bash
if [[ "$(uname)" == "Darwin" ]]; then
    # macOS specific
elif [[ -f /etc/debian_version ]]; then
    # Debian/Ubuntu specific
else
    # Generic Linux/other
fi
```

### 3. Shell Detection
```bash
if [[ -n "$ZSH_VERSION" ]]; then
    # Zsh-specific setup
elif [[ -n "$BASH_VERSION" ]]; then
    # Bash-specific setup
fi
```

### 4. File Naming Conventions
- `000-*.sh` - Early initialization (Homebrew, core paths)
- `999-*.sh` - Late initialization (final PATH adjustments)
- `alias.sh` - Command aliases
- `path.sh` - PATH modifications
- `load.sh` - Main tool initialization
- `env.sh` - Environment variables

### 5. Lazy Loading
For heavy tools (nvm, rvm, etc.), use lazy loading:
```bash
# Instead of loading immediately, create a function
nvm() {
    unset -f nvm
    source "$NVM_DIR/nvm.sh"
    nvm "$@"
}
```

## Common Patterns

### Adding to PATH
```bash
# Prepend (higher priority)
export PATH="/new/path:$PATH"

# Append (lower priority)
export PATH="$PATH:/new/path"
```

### Sourcing Completions
```bash
# Check for completion file
if [[ -f /path/to/completions ]]; then
    source /path/to/completions
fi
```

### Creating Aliases
```bash
# In tool/alias.sh
alias ll='ls -la'
alias gs='git status'

# Conditional aliases
command -v hub &> /dev/null && alias git='hub'
```

## Debugging

### Check Load Order
```bash
# See which files are being sourced and in what order
find ~/.dotfiles -name "*.sh" -o -name "*.zsh" | \
    grep -v "~/.dotfiles/bin/" | \
    awk -F'/' '{print $NF"|"$0}' | \
    sort -t"|" -k1n | \
    cut -f2- -d'|'
```

### Test Bootstrap Without Changes
```bash
# Dry run to see what would be linked
find ~/.dotfiles -type f -name 'dot.*' | while read -r file; do
    echo "Would link: $file -> ~/$(basename ${file#dot.})"
done
```

### Reload Configuration
```bash
# Reload current shell configuration
source ~/.zshrc  # or ~/.bashrc
```

## Maintenance

### Disable a Configuration
Rename the file to exclude `.sh`/`.zsh` extension:
```bash
mv tool/load.sh tool/load.sh.disabled
```

### Clean Broken Symlinks
```bash
find ~ -maxdepth 1 -type l ! -exec test -e {} \; -delete
```

### Update All Tools
```bash
# Example update script
brew update && brew upgrade  # macOS
apt update && apt upgrade     # Debian/Ubuntu
```

## Security Considerations

1. **Never commit secrets** - Use environment variables or secure storage
2. **Check file permissions** - Ensure private keys have correct permissions
3. **Review sourced files** - Be cautious with third-party shell scripts
4. **Use `command -v` over `which`** - More reliable and POSIX compliant

## Remote Hosts and tmux Considerations

When configuring remote hosts accessed via SSH, be aware of tmux behavior:

### Environment Variable Persistence
**Problem**: tmux "freezes" environment variables when sessions start. SSH-related variables become stale when reconnecting from different locations.

**Affected Variables**:
- `SSH_AUTH_SOCK` - SSH agent forwarding socket
- `SSH_CLIENT` - Origin IP and port information  
- `SSH_CONNECTION` - Connection details
- Custom variables set during SSH connection

### Solutions Implemented

#### 1. SSH Agent Socket Symlink
The `tmux-on-ssh.sh` script creates a stable symlink:
```bash
# Creates: ~/.ssh/ssh_auth_sock -> /tmp/ssh-agent.12345
export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"
```

This ensures SSH agent forwarding works in existing tmux shells even after reconnecting from different machines.

#### 2. Environment Variable Updates
The script updates tmux session environment on each connection:
```bash
tmux setenv -t "$SESSION_NAME" SSH_CLIENT "$SSH_CLIENT"
tmux setenv -t "$SESSION_NAME" SSH_CONNECTION "$SSH_CONNECTION"  
tmux setenv -t "$SESSION_NAME" SSH_AUTH_SOCK "$SSH_AUTH_SOCK_LINK"
```

**Note**: This only affects NEW shells/windows in tmux, not existing ones.

### Best Practices for Remote Configuration

1. **Test in Fresh Shells**: After changing remote configs, test in new tmux windows
2. **Use Symlinks for Sockets**: Follow the SSH agent socket pattern for other persistent resources
3. **Refresh Functions**: Create functions to manually update environment when needed:
   ```bash
   refresh-ssh() {
       if [[ -n "$TMUX" ]]; then
           export SSH_AUTH_SOCK=$(tmux showenv SSH_AUTH_SOCK | cut -d= -f2-)
           echo "SSH environment refreshed"
       fi
   }
   ```

4. **Consider Session Scope**: Some configurations should be session-wide, others per-connection

### Remote Debugging

When things don't work in tmux on remote hosts:

```bash
# Check if you're in tmux
echo $TMUX

# Check SSH agent forwarding
ssh-add -l

# Compare tmux env vs current shell
tmux showenv | grep SSH
env | grep SSH

# Test reverse tunnel detection
netstat -ln | grep 127.0.0.1 | grep LISTEN

# Refresh environment manually
source ~/.zshrc  # May not fix tmux-frozen vars
```

## Troubleshooting

### Tool Not Loading
1. Check if file has `.sh` or `.zsh` extension
2. Verify file is executable: `chmod +x file.sh`
3. Check for syntax errors: `bash -n file.sh`
4. Ensure tool is installed: `command -v toolname`

### Symlink Issues
1. Check existing file: `ls -la ~/.[filename]`
2. Remove if broken: `rm ~/.[filename]`
3. Re-run bootstrap: `~/.dotfiles/script/bootstrap`

### PATH Issues
1. Check current PATH: `echo $PATH`
2. Find duplicates: `echo $PATH | tr ':' '\n' | sort | uniq -d`
3. Verify order: Earlier entries take precedence

### tmux Environment Issues
1. Check if in tmux: `echo $TMUX`
2. Compare environments: `tmux showenv` vs `env`
3. Create new tmux window to test fresh environment
4. Use refresh functions to update existing shells
5. Verify SSH agent forwarding: `ssh-add -l`

## Contributing

When adding new tools or configurations:
1. Follow existing patterns and conventions
2. Include installation instructions for multiple platforms
3. Test on both macOS and Linux if possible
4. Document any special requirements or dependencies
5. Use descriptive commit messages

## Quick Reference

```bash
# Add new tool
mkdir ~/.dotfiles/newtool
vim ~/.dotfiles/newtool/load.sh
~/.dotfiles/script/bootstrap

# Reload configuration
source ~/.zshrc

# Check what's loaded
echo $DOTFILESDIR
echo $PATH | tr ':' '\n'

# Debug loading
bash -x ~/.bashrc 2>&1 | less
```