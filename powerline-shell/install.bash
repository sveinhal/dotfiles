
function _update_ps1() {
   PS1="$(powerline-shell $? 2> /dev/null)"
}
PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
