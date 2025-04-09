eval "$(jenv init -)"
jenv enable-plugin export
echo $(brew --prefix java) | xargs -n1 jenv add