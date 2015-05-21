# Makefile -- install and otherwise manipulate our vim configuration
#
# Chris Weyl <cweyl@alumni.drew.edu> 2013

# directories with Makefiles in them, that we may want to tickle
SUBDIRS = spell

.PHONY: spell $(SUBDIRS)

help:
	# I should really write a better help target, no?
	#
	# spell/Makefile:
	# ---------------
	#
	# spell:   update outdated/missing binary spellfiles
	# respell: aka "make clean; make spell"
	#
	# <spellfile>.add.spl: update a specific spellfile

spell:
	$(MAKE) -C spell

respell:
	$(MAKE) -C spell rebuild

fonts:
	@ echo '# ensuring fonts...'
	mkdir ~/.fonts ||:
	cd ~/.fonts && test -e Inconsolata-dz-Powerline.otf || ln -s ../.vim/powerline/fonts/Inconsolata-dz-Powerline.otf

dotfiles:
	@echo '# setting up dotfiles...'
	cd && test -e .gitconfig || ln -s .vim/dotfiles/gitconfig .gitconfig
	cd && touch .gitconfig.local && chmod 0600 .gitconfig.local

cleanup:
	@echo '# ensure obsolete bundles are removed...'
	./bin/rm-bundle vim-puppet

install: fonts
	@echo '# Setting up .vimrc, etc....'
	cd && test -e .vimrc || ln -s .vim/vimrc .vimrc
	touch ~/.vimrc.local
	chmod 0600 ~/.vimrc.local

zsh:
	@echo '# installing oh-my-zsh...'
	curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

install-all: install dotfiles cleanup

bundle-update:
	@echo '# committing submodule/bundle updates...'
	m=`git submodule | grep '^\+' | awk '{ print $$2 }' | xargs` ; git commit -m "updating: $$m" $$m

fetch-submodule-upstream:
	@echo '# pulling the latest submodule/bundle updates...'
	#m=`git submodule | grep '^\+' | awk '{ print $$2 }' | xargs` ; git commit -m "updating: $$m" $$m
	git submodule update --init
	git submodule foreach "sh -c '( git co master && git pull )'"

submodule-ensure-rebase:
	for sm in `git submodule | awk '{ print $$2 }'` ; do git config --file .gitmodules submodule.$$sm.update rebase ; done
	for sm in `git submodule | awk '{ print $$2 }'` ; do git config                    submodule.$$sm.update rebase ; done
	git submodule sync

ignore-tags:
	 find .git/modules -name 'exclude' -exec sh -c "echo 'doc/tags' >> {}" \;
