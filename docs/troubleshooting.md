# Troubleshooting Guide

Common issues and solutions for the dotfiles configuration.

## Installation Issues

### Bootstrap Script Fails

#### Symptom
```bash
~/.dotfiles/script/bootstrap
# Error: cannot create symlink
```

#### Solution
Check for existing files blocking symlinks:
```bash
# List potential conflicts
ls -la ~/ | grep -E "^\."

# Remove or backup existing files
mv ~/.bashrc ~/.bashrc.backup

# Re-run bootstrap
~/.dotfiles/script/bootstrap
```

### Symlinks Not Working

#### Symptom
Configuration changes not taking effect

#### Solution
```bash
# Check if symlinks are correct
ls -la ~/.zshrc
# Should show: .zshrc -> .dotfiles/zsh/dot.zshrc

# Fix broken symlinks
find ~ -maxdepth 1 -type l ! -exec test -e {} \; -delete
~/.dotfiles/script/bootstrap
```

## Shell Startup Issues

### Shell Won't Start / Hanging on Login

#### Emergency Access
```bash
# SSH without sourcing dotfiles
ssh server bash --norc
ssh server sh

# Fix locally
/bin/bash --norc
```

#### Common Causes
1. Syntax error in `.sh` file
2. Infinite loop in sourced script
3. Command requiring user input

#### Debugging
```bash
# Trace shell initialization
bash -x ~/.bashrc 2>&1 | less
zsh -x ~/.zshrc 2>&1 | less

# Find problematic file
for file in ~/.dotfiles/**/*.sh; do
    echo "Checking $file"
    bash -n "$file"
done
```

### Auto-Sourcing Problems

#### Symptom
Scripts running unexpectedly at shell startup

#### Solution
```bash
# Find auto-sourced files
find ~/.dotfiles -name "*.sh" -o -name "*.zsh" | sort

# Disable problematic script
mv ~/.dotfiles/tool/problem.sh ~/.dotfiles/tool/problem.sh.disabled

# For manual-run scripts, remove .sh extension
mv ~/.dotfiles/tool/script.sh ~/.dotfiles/tool/script
```

## Prompt Issues

### Prompt Not Displaying / Broken Characters

#### Check Oh My Posh Installation
```bash
# Verify installation
oh-my-posh version

# Reinstall if needed
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

#### Font Issues
```bash
# Install Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# Configure terminal to use installed font
```

### Prompt Performance

#### Symptom
Slow prompt rendering, lag when pressing enter

#### Debugging
```bash
# Profile prompt performance
oh-my-posh debug --shell zsh --config ~/.dotfiles/oh-my-posh/custom-powerline.json

# Check git performance in large repos
time git status
```

#### Solutions
- Disable git segment in large repositories
- Simplify prompt configuration
- Use faster prompt theme

### Colors Look Wrong

#### Check Terminal Support
```bash
# Verify 256-color support
echo $TERM
# Should be: xterm-256color

# Test colors
~/.dotfiles/bin/colors

# Set correct TERM
export TERM=xterm-256color
```

## Git Issues

### GPG Signing Fails

#### Symptom
```
error: gpg failed to sign the data
fatal: failed to write commit object
```

#### Solution
```bash
# Check GPG key
gpg --list-secret-keys

# Test signing
echo "test" | gpg --clearsign

# Reset GPG agent
gpgconf --kill gpg-agent
gpg-agent --daemon

# Configure git
git config --global gpg.program $(which gpg)
```

### Hub Command Not Working

#### Solution
```bash
# Check hub installation
which hub

# Install if missing
brew install hub

# Verify alias
alias git
# Should show: git='hub'
```

## PATH Issues

### Command Not Found

#### Debugging PATH
```bash
# Show current PATH
echo $PATH | tr ':' '\n'

# Check if dotfiles/bin is included
echo $PATH | grep -q "dotfiles/bin" && echo "Found" || echo "Not found"

# Manually add to PATH
export PATH="$HOME/.dotfiles/bin:$PATH"
```

### Duplicate PATH Entries

#### Clean PATH
```bash
# Remove duplicates
export PATH=$(echo "$PATH" | tr ':' '\n' | awk '!seen[$0]++' | tr '\n' ':')

# Check specific tool paths
which -a <command>
```

## Tool-Specific Issues

### Mise (Version Manager) Not Working

```bash
# Check installation
mise version

# Install if missing
curl https://mise.run | sh

# Activate
eval "$(mise activate zsh)"

# Install tools
mise install node@latest
```

### Zoxide Not Working

```bash
# Check installation
zoxide --version

# Install
brew install zoxide

# Initialize
eval "$(zoxide init zsh)"

# Rebuild database
zoxide import --from autojump  # if migrating
```

### tmux Issues

#### SSH Agent Not Working in tmux

```bash
# Check agent socket
echo $SSH_AUTH_SOCK

# In tmux, refresh environment
tmux setenv SSH_AUTH_SOCK $SSH_AUTH_SOCK

# Or create refresh function
refresh-ssh() {
    export $(tmux showenv SSH_AUTH_SOCK)
}
```

#### Can't Detach with Ctrl-D

```bash
# Check if script is loaded
which tmux-detach-on-ctrl-d

# Verify tmux prefix key
tmux show-options -g prefix
```

## SSH Issues

### ProxyCommand Fails

#### Debugging
```bash
# Test proxy script directly
~/.dotfiles/ssh/origin-proxy jump.host target.host 22

# Check SSH config
ssh -G hostname | grep proxy

# Verbose SSH
ssh -vvv hostname
```

### Agent Forwarding Not Working

```bash
# Check local agent
ssh-add -l

# Test forwarding
ssh -A hostname 'ssh-add -l'

# Fix socket in tmux
ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
```

## Platform-Specific Issues

### macOS

#### Homebrew Paths Not Working

```bash
# Check Homebrew installation
/opt/homebrew/bin/brew --version  # Apple Silicon
/usr/local/bin/brew --version      # Intel

# Re-initialize
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Linux

#### Different Command Options

```bash
# Check OS in scripts
if [[ "$(uname)" == "Linux" ]]; then
    alias ls='ls --color=auto'
else
    alias ls='ls -G'
fi
```

## Performance Issues

### Slow Shell Startup

#### Profile Loading Time
```bash
# Time shell startup
time zsh -i -c exit
time bash -i -c exit

# Profile each file
for file in ~/.dotfiles/**/*.sh; do
    echo -n "$file: "
    time source "$file"
done
```

#### Common Culprits
- Version managers (nvm, rvm)
- Completion scripts
- Network operations

#### Solutions
- Use lazy loading for heavy tools
- Disable unused features
- Use mise instead of individual version managers

## Recovery Procedures

### Reset to Clean State

```bash
# Backup current configuration
cp -r ~/.dotfiles ~/.dotfiles.backup

# Remove all symlinks
find ~ -maxdepth 1 -type l -exec rm {} \;

# Re-clone repository
rm -rf ~/.dotfiles
git clone https://github.com/sveinhal/dotfiles.git ~/.dotfiles

# Re-run bootstrap
~/.dotfiles/script/bootstrap
```

### Disable Everything Temporarily

```bash
# Start clean shell
env -i bash --norc --noprofile

# Or move dotfiles temporarily
mv ~/.dotfiles ~/.dotfiles.disabled
```

## Getting Help

### Debugging Commands

```bash
# Check shell version
echo $BASH_VERSION
echo $ZSH_VERSION

# List loaded files
echo $DOTFILESDIR

# Check specific tool
command -v <tool>
type <tool>
which <tool>
```

### Logs and Output

```bash
# Capture all output
script debug.log
source ~/.zshrc
exit

# Review debug.log for errors
```

## Common Error Messages

### "command not found"
- Check if tool is installed
- Verify PATH includes tool location
- Reload shell configuration

### "permission denied"
- Check file permissions: `ls -la <file>`
- Make executable: `chmod +x <file>`
- Check directory permissions

### "no such file or directory"
- Verify file exists: `ls -la <path>`
- Check symlinks: `readlink <file>`
- Ensure bootstrap was run

## Preventive Measures

1. **Test changes in new shell first**
   ```bash
   zsh  # New shell
   source ~/.dotfiles/new-config.sh
   ```

2. **Keep emergency access**
   - Know how to start shell without RC files
   - Have backup access method (different user, SSH key)

3. **Version control discipline**
   - Commit working configurations
   - Test changes before committing
   - Use branches for major changes

4. **Document customizations**
   - Add comments to custom scripts
   - Update CLAUDE.md with new patterns
   - Keep this troubleshooting guide updated