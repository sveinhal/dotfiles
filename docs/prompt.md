# Shell Prompt Configuration

The shell prompt is powered by **Oh My Posh** with a custom powerline theme that provides rich visual feedback about your environment and repository status.

## Configuration Files

- **Theme**: `oh-my-posh/custom-powerline.json`
- **Initialization**: `oh-my-posh/init.zsh`
- **Terminal Profile**: `Broadcast.terminal` (macOS)

## Prompt Segments

The prompt displays information in a powerline style with the following segments:

### 1. User Segment
- **Normal User**: Gray text on dark gray background (colors 252/242)
- **Root User**: White text on red background (colors 15/160)
- Shows username with powerline separator

### 2. Hostname Segment
- **Colors**: Light gray on dark background (252/238)
- Displays the system hostname
- Useful for identifying which machine you're on

### 3. SSH Indicator
- **Colors**: White on orange (15/208)
- Only appears when in an SSH session
- Shows "SSH" badge to remind you of remote connection

### 4. Home Directory Indicator
- **Colors**: White on green (15/32)
- Shows house icon (🏠) when in home directory
- Quick visual confirmation of location

### 5. Path Segment
- **Colors**: Light gray on gray (252/242)
- Shows current working directory
- Uses agnoster-style path shortening
- Custom separator: `/`

### 6. Git Branch Segment
Dynamic coloring based on repository state:
- **Clean**: White on green (15/35)
- **Dirty**: White on orange (15/214)
- **Ahead/Behind**: White on red (15/160)
- Shows branch icon and name

### 7. Git Working Changes
- **Colors**: White on brown (15/130)
- Shows unstaged changes in working directory
- Displays file counts and modification types

### 8. Git Staging Changes
- **Colors**: White on dark brown (15/94)
- Shows staged changes ready for commit
- Displays file counts

### 9. Git Branch Status
- **Colors**: Gray on dark gray (252/242)
- Shows ahead/behind counts relative to upstream
- Format: `↑n` (ahead) `↓n` (behind)

### 10. Write Permission Indicator
- **Colors**: White on red (15/160)
- Shows lock icon (🔒) when directory is not writable
- Important security/permission indicator

### 11. Status Code Segment
- **Colors**: White on light red (15/173)
- Only appears when last command failed
- Shows exit code and error reason:
  - `SEGV` for segmentation fault
  - `INT` for interrupted
  - `TERM` for terminated
  - Numeric code for other errors

## Recent Improvements

Based on commit history, the prompt has evolved significantly:

- **99bf28d**: Migrated from powerline-shell to Oh My Posh
- **6072788**: Enhanced prompt colors and symbols
- **5c686ed**: Improved git presentation with working/staging separation
- **59b823b**: Better status code rendering
- **5843ed7**: Red username for root, show non-zero exit codes

## Customization

### Modifying the Theme

Edit `oh-my-posh/custom-powerline.json` to customize:

```json
{
  "blocks": [
    {
      "type": "prompt",
      "alignment": "left",
      "segments": [
        // Segment definitions here
      ]
    }
  ]
}
```

### Color Reference

The theme uses 256-color mode. Test available colors with:
```bash
~/.dotfiles/bin/colors
```

### Powerline Symbols

The theme uses these Unicode powerline symbols:
- `` (U+E0B0): Right-pointing separator
- `` (U+E0B1): Right-pointing thin separator
- `` (U+E0B2): Left-pointing separator
- `` (U+E0B3): Left-pointing thin separator

## Terminal Requirements

### Font Requirements
You need a font with powerline symbols. Recommended fonts:
- Nerd Fonts (any variant)
- Powerline-patched fonts
- MesloLGS NF (Oh My Posh recommended)

### Terminal Settings
- **Colors**: 256-color support required
- **Unicode**: UTF-8 encoding
- **Profile**: Import `Broadcast.terminal` for optimal colors

## Troubleshooting

### Symbols Not Displaying
```bash
# Install a Nerd Font
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font
```

### Colors Look Wrong
```bash
# Check terminal color support
echo $TERM
# Should show: xterm-256color or similar

# Test colors
~/.dotfiles/bin/colors
```

### Prompt Not Loading
```bash
# Check Oh My Posh installation
oh-my-posh version

# Reinstall if needed
brew install jandedobbeleer/oh-my-posh/oh-my-posh
```

### Performance Issues
```bash
# Check prompt render time
oh-my-posh debug --shell zsh --config ~/.dotfiles/oh-my-posh/custom-powerline.json
```

## Alternative Prompts

The repository includes legacy prompt configurations:

- **powerline-shell**: Previous prompt system (deprecated)
- Can be re-enabled by modifying `zsh/prompt.zsh`

## Integration with tmux

When using tmux, the prompt works seamlessly but note:
- Terminal title updates may not propagate
- Some color adjustments might be needed in `.tmux.conf`
- SSH indicator remains accurate through tmux sessions