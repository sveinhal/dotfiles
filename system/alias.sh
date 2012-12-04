alias ls='ls -G'
alias ll='ls -l'
alias la='ls -a'
alias mv='mv -i'
alias cp='cp -i'
alias grep='grep --color=auto'

arch=`uname`
case $arch in
    FreeBSD|Linux)
	alias su='su -m'
	;;
    Darwin)
	;;
esac

