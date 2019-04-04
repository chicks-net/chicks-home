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
	. /home/chicks/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=1
	export GIT_PS1_SHOWUNTRACKEDFILES=1
	export GIT_PS1_SHOWSTASHSTATE=1

	# PS1 = bash prompt
	# dark purple
	#PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

	# red for root, green for users
	if [[ ${EUID} == 0 ]] ; then
		PS1='${debian_chroot:+($debian_chroot)}\[\e[01;31m\]\h\[\e[01;35m\] \t \[\e[01;36m\]\W \[\e[01;34m\]!\! \$\[\e[00m\] '
	else
		PS1='${debian_chroot:+($debian_chroot)}\[\e[01;32m\]\u@\h\[\e[35;1m\] \t \[\e[01;36m\]\W\[\e[01;31m\]$(__git_ps1 " (%s)") \[\e[01;34m\]!\! \$\[\e[00m\] '
	fi

	# fix xterm titles
	PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

	# don't let leading spaces cause commands to be forgotten
	export HISTCONTROL=ignoredups:erasedups  
	# When the shell exits, append to the history file instead of overwriting it
	shopt -s histappend

	# bc needs defaults
	export BC_ENV_ARGS=~/.bcrc

	# cows get old fast
	export ANSIBLE_NOCOWS=1

	# perl local::lib
	if [ -d /home/chicks/perl5 ]; then
		eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
	fi

	# debian packager
	export DEBFULLNAME="Christopher Hicks"
	export DEBEMAIL="chicks@bastille.io"

	check_packages
	echo ""

	check_all_permissions
	echo ""

	uptime
	echo ""
fi

