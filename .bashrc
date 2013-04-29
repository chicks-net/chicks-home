# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PATH=$PATH:/sbin:/usr/sbin

PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "
