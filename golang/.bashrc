PS1='\[\033[38;5;226m\]\u\[$(tput sgr0)\]@\[$(tput sgr0)\]\[\033[38;5;70m\]\h\[$(tput sgr0)\]: \[$(tput sgr0)\]\[\033[38;5;33m\]\W\[$(tput sgr0)\] \[\033[38;5;1m\]\$\[$(tput sgr0)\] '

 export LS_OPTIONS='--color=auto'
 eval "`dircolors`"
 alias ls='ls $LS_OPTIONS'
 alias ll='ls $LS_OPTIONS -l'
 alias l='ls $LS_OPTIONS -lAh'
 alias cls='clear'
 cd /go/src
 cls
 # cat /etc/motd
# cat motd.extra
 ip=`ip addr | grep "inet 10.105\b" | awk '{print $2}' | cut -d/ -f1`
 echo 'IP : '$ip
 echo