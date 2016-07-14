# Makefile -- install and otherwise manipulate our vim configuration
#
# Chris Weyl <cweyl@alumni.drew.edu> 2013

# directories with Makefiles in them, that we may want to tickle
SUBDIRS = spell

.PHONY: $(SUBDIRS) help

help:
	# I should really write a better help target, no?
	#
	# spell:   update outdated/missing binary spellfiles
	# respell: aka "make clean; make spell"
	#
	# commit-spellings: respell, then commit everything under spell/

###########################################################
# spelling!

spell:
	$(MAKE) -C spell

respell:
	$(MAKE) -C spell rebuild

commit-spellings: respell
	git add -A spell/ && git commit -m 'more spellinks' spell/

.PHONY: spell respell commit-spellings bootstrap

###########################################################
# ...

bootstrap:
	git subtree pull --prefix=bootstrap/vim-plug --squash https://github.com/junegunn/vim-plug.git master

fonts:
	@ echo '# ensuring fonts...'
	mkdir ~/.fonts ||:
	cd ~/.fonts && test -e Inconsolata-dz-Powerline.otf || ln -s ../.vim/powerline/fonts/Inconsolata-dz-Powerline.otf

dotfiles:
	@echo '# setting up dotfiles...'
	cd && test -e .gitconfig || ln -s .vim/dotfiles/gitconfig .gitconfig
	cd && touch .gitconfig.local && chmod 0600 .gitconfig.local

install: fonts
	@echo '# Setting up .vimrc, etc....'
	cd && test -e .vimrc || ln -s .vim/vimrc .vimrc
	touch ~/.vimrc.local
	chmod 0600 ~/.vimrc.local

zsh:
	@echo '# installing oh-my-zsh...'
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

install-all: install dotfiles cleanup
