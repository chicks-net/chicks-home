# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source chicks definitions
if [ -f /home/chicks/.functions ]; then
	. /home/chicks/.functions
fi

# User specific aliases and functions
PATH=$PATH:/sbin:/usr/sbin

PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

# TODO: does bashrc run only for interactive mode?

if is_interactive; then
	#echo non-interactive
	false
else
	check_packages
	echo ""

	check_all_permissions
	echo ""

	uptime
	echo ""
fi

