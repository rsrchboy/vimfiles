# Makefile -- install and otherwise manipulate our vim configuration
#
# Chris Weyl <cweyl@alumni.drew.edu> 2013

fonts::
	@ echo '# ensuring fonts...'
	mkdir ~/.fonts ||:
	cd ~/.fonts && test -e Inconsolata-dz-Powerline.otf || ln -s ../.vim/powerline/fonts/Inconsolata-dz-Powerline.otf

dotfiles::
	@echo '# setting up dotfiles...'
	cd && test -e .gitconfig || ln -s .vim/dotfiles/gitconfig .gitconfig
	cd && touch .gitconfig.local && chmod 0600 .gitconfig.local

cleanup::
	@echo '# ensure obsolete bundles are removed...'
	./bin/rm-bundle vim-puppet

install:: fonts
	@echo '# Setting up .vimrc, etc....'
	cd && test -e .vimrc || ln -s .vim/vimrc .vimrc
	touch ~/.vimrc.local
	chmod 0600 ~/.vimrc.local

install-all:: install dotfiles cleanup

bundle-update::
	@echo '# committing submodule/bundle updates...'
	m=`git submodule | grep '^\+' | awk '{ print $$2 }' | xargs` ; git commit -m "updating: $$m" $$m

submodule-ensure-rebase::
	for sm in `git submodule | awk '{ print $$2 }'` ; do git config --file .gitmodules submodule.$$sm.update rebase ; done
	for sm in `git submodule | awk '{ print $$2 }'` ; do git config                    submodule.$$sm.update rebase ; done
	git submodule sync

ignore-tags::
	 find .git/modules -name 'exclude' -exec sh -c "echo 'doc/tags' >> {}" \;
