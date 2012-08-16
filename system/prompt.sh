# *** FORANDRE PROMPT
        case $TERM in
            xterm*)
                if [ "$UID" = 0 ]; then
                        COL=34m
                else
                        COL=31m
                fi
		PS1="\[\e[${COL}\][\u@\h:\w]\\$ \[\e[0m\]"
                ;;
        esac

