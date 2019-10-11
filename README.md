Some opinionated shell setup for OS X.

This includes some standard config files for git, bash, rvm, nvm, and command line scripts.

To install:

```sh
$ git clone git@github.com:sveinhal/dotfiles.git ~/.dotfiles # creates a hidden .dotfiles directory
$ ~/.dotfiles/script/bootstrap #installs .bashrc, etc. Does not overwrite anything
```

### Bootstrap
The `bootstrap` script works by finding all files in the `.dotfiles` directory named `dot.*` and creates a symlink `~/.foo -> .dotfiles/some/path/dot.foo`. This includes among other things `.zshrc`. This files is executed on every new shell.

### .zshrc
The `.zshrc` script will find all files `*.sh` and `*.zsh` in the `.dotfiles` directory and source them.
This allows one to place various small well-contained files around the `.dotfiles` directory. E.g put git alias config in `.dotfiles/git/alias.sh` or zsh prompt config in `.dotfiles/zsh/prompt.zsh`, etc. To disable a file, just rename it to e.g. `foo.sh.disabled` (or some other name that does not end in `.sh`).

The files are sorted numerically before being sourced, so to make the files be sourced in a certain order, you can prefix the files with a number. Say `.dotfiles/some/path/999-should-happen-last.sh` or `.dotfiles/dir/000-important.sh`

### $PATH
In addition to setting up various tools, this also adds `~/.dotfiles/bin` to your `$PATH` making some bundled scripts and tools available.
