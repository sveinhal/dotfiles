function _update_ps1() {
   PS1="$($DOTFILESDIR/powerline-shell/powerline-shell.py $? 2> /dev/null)"
}
PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
