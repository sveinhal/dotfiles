# Custom Scripts Reference

The `bin/` directory contains custom scripts and utilities that enhance your command-line experience. These scripts are automatically added to your PATH.

## Git Utilities

### git-delete-squashed
**Purpose**: Delete local branches that have been merged and squashed into main/master  
**Usage**: `git-delete-squashed [base-branch]`  
**Description**: Helps clean up local branches after they've been squash-merged via pull requests. Compares branch commits with the base branch to detect squash merges.

### git-promote
**Purpose**: Promote a local branch to upstream (origin)  
**Usage**: `git-promote [branch-name]`  
**Description**: Sets up tracking for a local branch and pushes it to the remote repository. Useful for sharing feature branches.

### git-rank-contributers
**Purpose**: Display repository contributors ranked by number of commits  
**Usage**: `git-rank-contributers`  
**Description**: Shows a ranked list of all contributors to the repository with their commit counts. Great for understanding project participation.

### git-up
**Purpose**: Update repository with rebase instead of merge  
**Usage**: `git-up`  
**Description**: Fetches latest changes and rebases your current branch on top of upstream. Keeps history linear and clean.

### git-wtf
**Purpose**: Display detailed repository and branch status  
**Usage**: `git-wtf [branch]`  
**Description**: Shows comprehensive information about branches, their relationships, commits ahead/behind, and remote tracking status.

## System Utilities

### battery
**Purpose**: Display battery status and charge level  
**Usage**: `battery`  
**Description**: Shows current battery percentage and charging status on macOS.

### colors
**Purpose**: Display 256-color palette in terminal  
**Usage**: `colors`  
**Description**: Prints a grid showing all 256 colors available in your terminal. Useful for theme development and testing terminal color support.

### tcolors
**Purpose**: Test terminal color capabilities  
**Usage**: `tcolors`  
**Description**: Alternative color testing utility with different output format.

### wifi-signal-strength
**Purpose**: Show WiFi signal strength  
**Usage**: `wifi-signal-strength`  
**Description**: Displays current WiFi connection strength and quality metrics.

## Development Tools

### e
**Purpose**: Smart editor launcher  
**Usage**: `e [file]`  
**Description**: Opens files in your preferred editor. Detects and uses the best available editor (VSCode, Sublime, vim, etc.).

### diffmerge
**Purpose**: Enhanced diff and merge tool  
**Usage**: `diffmerge file1 file2`  
**Description**: Visual diff and merge utility for comparing files and resolving conflicts.

### headers
**Purpose**: Display HTTP headers for a URL  
**Usage**: `headers <url>`  
**Description**: Fetches and displays HTTP response headers. Useful for debugging web services and APIs.

### prettyJSON
**Purpose**: Format and pretty-print JSON data  
**Usage**: `prettyJSON < input.json` or `echo '{"key":"value"}' | prettyJSON`  
**Description**: Takes JSON input and outputs formatted, indented JSON for better readability.

### regex
**Purpose**: Test regular expressions  
**Usage**: `regex <pattern> <string>`  
**Description**: Quick regex pattern testing from the command line.

## File and Text Manipulation

### search
**Purpose**: Enhanced file search  
**Usage**: `search <pattern> [directory]`  
**Description**: Recursive search for patterns in files with highlighting and context.

### ignore-moved-lines
**Purpose**: Filter out moved lines from diffs  
**Usage**: `git diff | ignore-moved-lines`  
**Description**: Helps focus on actual changes by filtering out lines that were just moved around.

### random
**Purpose**: Generate random strings or numbers  
**Usage**: `random [length]`  
**Description**: Generates random alphanumeric strings for passwords, tokens, or testing.

## Media and Fun

### lyrics
**Purpose**: Fetch song lyrics  
**Usage**: `lyrics <artist> <song>`  
**Description**: Retrieves and displays lyrics for the specified song.

### mustacheme
**Purpose**: Add mustache to images  
**Usage**: `mustacheme <image-file>`  
**Description**: Fun utility that adds a mustache overlay to portrait images.

### movieme
**Purpose**: Create animated GIFs from video  
**Usage**: `movieme <video-file>`  
**Description**: Converts video files to animated GIFs for easy sharing.

### p4merge
**Purpose**: Perforce merge tool integration  
**Usage**: `p4merge file1 file2 [file3] [output]`  
**Description**: Visual three-way merge tool, useful for complex merge conflicts.

## Productivity Tools

### notes
**Purpose**: Quick note-taking system  
**Usage**: `notes [note-text]` or `notes -l` to list  
**Description**: Simple command-line note-taking utility. Stores timestamped notes for later reference.

### on
**Purpose**: Run commands when files change  
**Usage**: `on <file-pattern> <command>`  
**Description**: File watcher that executes commands when specified files are modified. Great for automatic testing or building.

### drwhen
**Purpose**: Display file modification times  
**Usage**: `drwhen [directory]`  
**Description**: Shows when files in a directory were last modified, sorted by time.

## Cloud and Services

### cloudapp
**Purpose**: Upload files to CloudApp  
**Usage**: `cloudapp <file>`  
**Description**: Quickly upload and share files via CloudApp service, returns shareable URL.

### heroku-copy-confg.sh
**Purpose**: Copy Heroku app configuration  
**Usage**: `heroku-copy-confg.sh <source-app> <dest-app>`  
**Description**: Copies environment variables and configuration from one Heroku app to another.

## Visualization

### spark
**Purpose**: Create sparkline graphs in terminal  
**Usage**: `echo "1 5 3 8 2" | spark`  
**Output**: `▁▄▃█▂`  
**Description**: Generates Unicode sparkline graphs from numeric data. Great for quick data visualization.

### blister
**Purpose**: Generate visual representations of data  
**Usage**: `blister [data]`  
**Description**: Creates block-based visualizations of numeric data in the terminal.

## iOS/macOS Development

### swift-symbols
**Purpose**: Search SF Symbols  
**Usage**: `swift-symbols <search-term>`  
**Description**: Search and display Apple SF Symbols for iOS/macOS development.

### xibition
**Purpose**: XIB file utilities  
**Usage**: `xibition <xib-file>`  
**Description**: Tools for working with Interface Builder XIB files.

### set-defaults
**Purpose**: Configure macOS defaults  
**Usage**: `set-defaults`  
**Description**: Applies preferred macOS system settings and defaults.

## Usage Tips

### Making Scripts Executable
All scripts in `bin/` should be executable:
```bash
chmod +x ~/.dotfiles/bin/script-name
```

### Adding New Scripts
1. Create script in `~/.dotfiles/bin/`
2. Make it executable
3. It's automatically in PATH after shell reload

### Script Standards
- Use `#!/usr/bin/env bash` or appropriate shebang
- Include usage information with `-h` or `--help` flag
- Handle errors gracefully
- Use meaningful exit codes

## Troubleshooting

### Script Not Found
```bash
# Verify script is in PATH
which script-name

# Check if executable
ls -la ~/.dotfiles/bin/script-name

# Reload shell configuration
source ~/.zshrc
```

### Permission Denied
```bash
chmod +x ~/.dotfiles/bin/script-name
```

### Debugging Scripts
```bash
# Run with debug output
bash -x ~/.dotfiles/bin/script-name
```

## Contributing New Scripts

When adding new scripts:
1. Follow existing naming conventions (lowercase, hyphens)
2. Include help text and usage examples
3. Make scripts POSIX-compatible when possible
4. Test on both macOS and Linux if applicable
5. Document the script in this file