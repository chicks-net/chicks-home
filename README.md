# chicks-home

[![Open Source Love png2](https://badges.frapsoft.com/os/v2/open-source.png?v=103)](https://github.com/ellerbrock/open-source-badges/)
[![GPLv2 license](https://img.shields.io/badge/License-GPLv2-blue.svg)](https://github.com/chicks-net/chicks-home/blob/master/LICENSE)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/chicks-net/chicks-home/graphs/commit-activity)

This project was begun to simplify my life for maintaining my home
directory across numerous servers running different versions of Linux.
It checks to make sure that useful packages are installed and makes it
easy to install the missing ones.  I am testing it on Mint and CentOS.  It works
around the idiosyncracies of both so you get colorful prompts and `xterm`/window
titles update with your home directory.

This is also where a few of my scripts live that don't deserve their own repo:

- `closefh` - when you don't want to inheret a file handle, close it
- `roll` - a D&D-style dice roller.  This is critical infrastructure when the Magic 8-Ball (TM) is not available.
- `ruler` - counting characters by hand is silly, use a ruler on the command line
- `comify` - turn newlines into commas
- `watch_constate` - watch network connection states ala `vmstat` or `iostat`
- `github_fix_https` - make a repo cloned via `https` have ssh remotes


## USAGE

The first example shows using the function library and package installation features:

```ShellSession
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
```

Here is using the `check_ssl` script:

```ShellSession
chicks@waterpark $ ./check_ssl www.google.com:443
www.google.com:443:
notBefore=Jul 28 11:40:00 2016 GMT
notAfter=Oct 20 11:40:00 2016 GMT
chicks@waterpark $ ./check_ssl
dev.sepi.fini.net:443:
notBefore=Jun  5 22:00:00 2016 GMT
notAfter=Sep  3 22:00:00 2016 GMT
prod.ireserve.info:443:
notBefore=Apr 20 22:36:42 2014 GMT
notAfter=Aug  5 19:17:16 2016 GMT
```

## INSTALL

Typically I clone the repo and setup symlinks these days.
I'm open to ideas for doing this better.
I might be working ways to automate this myself.

Via shell commands:

```ShellSession
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
```

We used to support ansible as an option, but gave up because we don't trust IBM/Red Hat anymore.

## TODO

- finish mysql backups scripts
- find solution to git/permissions issues generally "would you trust it with /etc?"
- integrate one of the cleaner ANSI color implementations


## EXPERIMENTS

There are a few areas where work is in progress:

- `daily_mysql_backup` is 50% done but hopes to make maintaining remote SQL-level backups easy and efficient
- *tmux* setup.  I'm reading an e-book and starting to integrate it into my workflow.  I've also started [libtmux](https://github.com/chicks-net/libtmux) for automation via tmux.

## SUPPORT

Feel free to file [issues](https://github.com/chicks-net/chicks-home/issues) on
github or send pull requests.

I started friendlier docs in [github pages](http://chicks-net.github.io/chicks-home/)
but since I have to maintain them in HTML instead of Markdown they have been
thoroughly neglected.  Since I got hugo working for a couple of sites I will
eventually go in that direction for documenting this repo.
