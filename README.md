chicks-home
===========

This project was begun to simplify my life for maintaining my home directory across numerous servers running different versions of Linux.
It checks to make sure that useful packages are installed and makes it easy to install the missing ones.
I am testing it on Mint and CentOS.  It works around the idiosyncracies of both so you get colorful prompts and xterm/window titles update with your home directory.

This is also where a few of my scripts live that don't deserve their own repo:

* `closefh` - when you don't want to inheret a file handle, close it
* `roll` - a D&D-style dice roller.  This is critical infrastructure when the Magic 8-Ball (TM) is not available.
* `ruler` - counting characters is silly, use a ruler
* `comify` - turn newlines into commas

INSTALL
-------

	adduser chicks
	cd /home
	mv chicks chicks.sys
	# setup temp keys
	git clone git@github.com:chicks-net/chicks-home.git
	mv chicks-home chicks
	chown -r chicks.chicks chicks
	cd chicks
	mkdir Documents Desktop tmp Mail Documents/git
	# keygen for chicks, add to github and authorized_keys
	# download dnetc


TODO
----

* retest in RedHat/CentOS
* finish mysql backups scripts
* write cron to keep home dirs up to date
* write script to populate home directory from github on new machines (the INSTALL section above should be a guideline)
* find solution to git/permissions issues generally "would you trust it with /etc?"
* integrate one of the cleaner ANSI color implementations


EXPERIMENTS
-----------

There are a few areas where work is in progress:

* `daily_mysql_backup` is 50% done but hopes to make maintaining remote SQL-level backups easy and efficient
* *tmux* setup.  I'm reading an e-book and starting to integrate it into my workflow.  I've also started [libtmux](https://github.com/chicks-net/libtmux) for automation via tmux.

SUPPORT
-------

Feel free to file issues on github or send pull requests.

I've started friendlier docs at http://chicks-net.github.io/chicks-home/ but since I have to maintain them in HTML instead of markdown they are being thoroughly neglected until I find a better workflow.

