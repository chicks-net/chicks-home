chicks-home
===========

My home directory with various scripts and configs.

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

* fix prompt under Mint
* finish mysql backups scripts
* find solution to git/permissions issues generally "would you trust it with /etc?"
* write cron to keep home dirs up to date
* write script to populate home directory from github on new machines
