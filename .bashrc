# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
PATH=$PATH:/sbin:/usr/sbin

PS1="\[\e[32m\]\u@\h \t \W \\$\[\e[0m\] "

# TODO: does bashrc run only for interactive mode?

GOODRPMS="vim-enhanced mtr"

for rpm in $GOODRPMS
do
	if rpm -q $rpm > /dev/null 2>&1
	then
		#echo good $rpm
		true
	else
		echo bad $rpm
	fi
done
