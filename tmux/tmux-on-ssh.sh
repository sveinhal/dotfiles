TMUX_CMD=$(command -v tmux) 
if [ -x "${TMUX_CMD}" ] && [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    SESSION_NAME=$(hostname)
    tmux new-session -As "$SESSION_NAME"
    logout
fi
