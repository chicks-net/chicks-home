# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH=$PATH:$HOME/bin:/sbin:/usr/sbin:$HOME/.local/bin


# cpanminus local::lib

#PATH="/home/chicks/perl5/bin${PATH+:}${PATH}"; export PATH;
export PERL5LIB="/home/chicks/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
export PERL_LOCAL_LIB_ROOT="/home/chicks/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
export PERL_MB_OPT="--install_base \"/home/chicks/perl5\""
export PERL_MM_OPT="INSTALL_BASE=/home/chicks/perl5"
