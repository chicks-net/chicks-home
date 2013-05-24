# .bashrc

# Source system-wide definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source chicks definitions
if [ -f /home/chicks/.functions ]; then
	. /home/chicks/.functions
fi

# Source chicks aliases
if [ -f /home/chicks/.aliases ]; then
	. /home/chicks/.aliases
fi

# environment variables
PATH=$PATH:/sbin:/usr/sbin
PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

if is_interactive; then
	# non-interactive, stay quiet
	false
else
	# interactive, do stuff
	check_packages
	echo ""

	check_all_permissions
	echo ""

	uptime
	echo ""
fi

