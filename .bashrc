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

	# PS1 = bash prompt
	# dark purple
	#PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

	# red for root, green for users
	if [[ ${EUID} == 0 ]] ; then
		PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\h\[\e[01;35m\] \t \[\e[01;36m\]\W \[\e[01;34m\]!\! \$\[\e[00m\] '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[35;1m\] \t \[\e[01;36m\]\W \[\e[01;34m\]!\! \$\[\e[00m\] '
	fi

	# fix xterm titles
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

	# don't let leading spaces cause commands to be forgotten
	set HISTCONTROL=ignoredups

	# bc needs defaults
	export BC_ENV_ARGS=~/.bcrc

	check_packages
	echo ""

	check_all_permissions
	echo ""

	uptime
	echo ""
fi

