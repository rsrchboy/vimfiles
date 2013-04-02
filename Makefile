# Makefile -- install and otherwise manipulate our vim configuration
#
# Chris Weyl <cweyl@alumni.drew.edu> 2013

install::
	@echo "Setting up .vimrc, etc...."
	( cd && ln -s .vim/vimrc .vimrc && touch .vimrc.local)
