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


USAGE
-----
	chicks@chickshp 09:32:10 chicks-home !224 $ . .functions 
	chicks@chickshp 09:32:14 chicks-home !225 $ check_packages 
	check_packages()...
		git-svn is not installed
		# sudo apt-get install  git-svn
	check done.
	chicks@chickshp 09:32:19 chicks-home !226 $ check_packages -i
	check_packages(-i)...
		git-svn is not installed
	Reading package lists... Done
	Building dependency tree       
	Reading state information... Done
	Suggested packages:
	  subversion
	The following NEW packages will be installed:
	  git-svn
	0 upgraded, 1 newly installed, 0 to remove and 137 not upgraded.
	Need to get 0 B/42.3 kB of archives.
	After this operation, 612 kB of additional disk space will be used.
	Selecting previously unselected package git-svn.
	(Reading database ... 246615 files and directories currently installed.)
	Unpacking git-svn (from .../git-svn_1%3a1.8.1.2-1_all.deb) ...
	Processing triggers for man-db ...
	Setting up git-svn (1:1.8.1.2-1) ...
	check done.
	chicks@chickshp 09:32:33 chicks-home !227 $ 


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
* choose/commit a LICENSE
* write script to populate home directory from github on new machines (the INSTALL section above should be a guideline)
* find solution to git/permissions issues generally "would you trust it with /etc?"
* integrate one of the cleaner ANSI color implementations


EXPERIMENTS
-----------

There are a few areas where work is in progress:

* `daily_mysql_backup` is 50% done but hopes to make maintaining remote SQL-level backups easy and efficient
* *tmux* setup.  I'm reading an e-book and starting to integrate it into my workflow.  I've also started [libtmux](https://github.com/chicks-net/libtmux) for automation via tmux.
* *CLI clock*  I'm proud to be working with tabelspoon on [fun](https://github.com/chicks-net/tablespooon-fun) which includes a sexy console-mode clock which supports multiple time zones and color..

SUPPORT
-------

Feel free to file issues on github or send pull requests.

I've started friendlier docs at http://chicks-net.github.io/chicks-home/ but since I have to maintain them in HTML instead of markdown they are being thoroughly neglected until I find a better workflow.

