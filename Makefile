#!/usr/bin/env make
# a couple targets to assist in maintaining my vim setup
#
# Chris Weyl <cweyl@alumni.drew.edu> 2017

.PHONY: bootstrap commit-spellings unshallow

bootstrap:
	git -c log.showSignature=false subtree pull --prefix=bootstrap/vim-plug --squash https://github.com/junegunn/vim-plug.git master

commit-spellings:
	git commit -m 'Spellings!' spell/

unshallow:
	git fetch --unshallow
