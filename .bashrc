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

# PS1 = bash prompt
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi



if is_interactive; then
	# non-interactive, stay quiet
	false
else
	# interactive, do stuff
	echo ""

	if [[ ${EUID} == 0 ]] ; then
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
	fi

	# ignore all of that for now and go with the old thing
	# dark purple
	PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

	check_packages
	echo ""

	check_all_permissions
	echo ""

	uptime
	echo ""
fi

