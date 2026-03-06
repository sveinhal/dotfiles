if command -v pvesh >/dev/null 2>&1 || [ -x /usr/sbin/pvesh ]; then
    alias qm='sudo /usr/sbin/qm'
    alias pct='sudo /usr/sbin/pct'
    alias pvesh='sudo /usr/sbin/pvesh'
fi
