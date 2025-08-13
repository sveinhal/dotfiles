TMUX_CMD=$(command -v tmux) 
if [ -x "${TMUX_CMD}" ] && [ -n "$SSH_CONNECTION" ] && [ -z "$TMUX" ]; then
    SESSION_NAME=$(hostname)
    
    # Create stable SSH agent socket symlink for tmux persistence
    SSH_AUTH_SOCK_LINK="$HOME/.ssh/ssh_auth_sock"
    
    # Update symlink to current SSH agent socket before attaching to tmux
    if [ -n "$SSH_AUTH_SOCK" ]; then
        # Ensure .ssh directory exists
        mkdir -p "$HOME/.ssh"
        # Create/update symlink to current agent socket
        ln -sf "$SSH_AUTH_SOCK" "$SSH_AUTH_SOCK_LINK"
        # Use symlink as agent socket - this persists across tmux sessions
        export SSH_AUTH_SOCK="$SSH_AUTH_SOCK_LINK"
    fi
    
    # Update tmux environment with current SSH variables before attaching
    if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
        # Session exists - update environment variables
        tmux setenv -t "$SESSION_NAME" SSH_CLIENT "$SSH_CLIENT" 2>/dev/null
        tmux setenv -t "$SESSION_NAME" SSH_CONNECTION "$SSH_CONNECTION" 2>/dev/null
        tmux setenv -t "$SESSION_NAME" SSH_TTY "$SSH_TTY" 2>/dev/null
        tmux setenv -t "$SESSION_NAME" SSH_AUTH_SOCK "$SSH_AUTH_SOCK_LINK" 2>/dev/null
    fi
    
    tmux new-session -As "$SESSION_NAME"
    logout
fi
