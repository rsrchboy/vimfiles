# vim bundle notes

This is a collection -- a substatntially revised collection -- of vim plugins
and configuration that I use.  It has been substatnially reduced from where it
once was, simply as I'd concluded that I need to refactor, reassess, and
ensure I use current and correct plugins, effectively.

(The older, sloppier vimrc is still availble under refs/attic/old-master.
Note this refspec is not pulled by default.)

# Methodology

## Local and private configuration information

We source the ```~/.vimrc.local``` file at the end of this one such that
per-machine or private information may be stored (e.g. authentication
credentials and the like).  This file is not and should never be stored in
version control.

## Location and Installation

This repository is set up such that it can be installed as your ```~/.vim```.
Running the contained ```Makefile``` will set up the appropriate symlinks,
including ```~/.vimrc``` and ensuring that an ```~/.vimrc.local``` exists and
has restrictive permissions (rw-------, aka 0600).

```
make install
```

Alternative locations (that is, not storing this repo in ~/.vim) is not
currently supported by the ```Makefile```, though could certainly be handled
trivially by hand.

## Bundle Management

For bundle management, we use [Tim Pope's](/tpope) excellent
[Pathogen](/tpope/pathogen) module.

Whenever pratical, external code and plugins are embedded and managed via git
submodules, and stashed under ```bundle/```.  There are some submodules that
do not fit the standard layout; those are generally stored under ```cranky/```
and synlinked into ```bundle/``` as appropriate.

# Git integration




# Interfaces with web applications


## Trac

We use the fantastic [vitra](http://nsmgr8.github.io/vitra) plugin to interface
with Trac instances.  Note that this requires the Trac XML-RPC interface to
be installed and active as well as the appropriate configuration information
defined in ```~/.vimrc.local```.

GitHub: [/nsmgr8/vitra]

## WordPress


## GitHub


### Gists


### Issues


# Plugins

See ```bundle/``` for an always up-to-date, complete list.

 * sadsa

* sadsa

# Custom mappings



# TODO

# LICENSE, COPYRIGHT and AUTHORSHIP

All code not written by [Chris Weyl](/RsrchBoy), including but not limited to
included plugins, linked submodules, etc, and the like are copyright their
respecitve creators and licensed under their terms.  For information, please
see any files in question for embedded information.

Copyright 2013 Chris Weyl <cweyl@alumni.drew.edu>

## Specific files

I'll try to keep a list of included files that are not of my origin here.
However, this is for convienence only, and for any real determiniations the
files themselves should be inspected for copyright, licensing and ownership
information.


