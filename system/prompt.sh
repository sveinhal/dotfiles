# *** FORANDRE PROMPT
        case $TERM in
            xterm*)
                if [ "$UID" = 0 ]; then
                        COL=34m
                else
                        COL=31m
                fi
		GIT_PS1_SHOWDIRTYSTATE=1
		PS1='\[\e[${COL}\][\u@\h:\w]\[\e[32m\]$(__git_ps1)\[\e[0m\]\\$ '
                ;;
        esac
