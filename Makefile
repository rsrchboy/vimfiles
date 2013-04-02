# Makefile -- install and otherwise manipulate our vim configuration
#
# Chris Weyl <cweyl@alumni.drew.edu> 2013

fonts::
	@ echo "# ensuring fonts..."
	mkdir ~/.fonts ||:
	cd ~/.fonts && test -e Inconsolata-dz-Powerline.otf || ln -s ../.vim/powerline/fonts/Inconsolata-dz-Powerline.otf

install:: fonts
	@echo "# Setting up .vimrc, etc...."
	cd && test -e .vimrc || ln -s .vim/vimrc .vimrc
	touch ~/.vimrc.local
	chmod 0600 ~/.vimrc.local
