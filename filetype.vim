au BufNewFile,BufRead apparmor.d/*               set filetype=apparmor
au BufRead,BufNewFile *.cson                     set ft=coffee
au BufRead,BufNewFile ansible/**/files/sshkeys/* set filetype=sshauthkeys
au BufRead,BufNewFile .gitpan                    set filetype=yaml

au BufNewFile,BufRead *.psgi              set filetype=perl
au BufNewFile,BufRead cpanfile            set filetype=perl
au BufNewFile,BufRead alienfile           set filetype=perl
au BufNewFile,BufRead Rexfile             set filetype=perl
au BufNewFile,BufRead *.tt                set filetype=tt2html
au BufNewFile,BufRead *.tt2               set filetype=tt2html
au BufNewFile,BufRead Changes             set filetype=changelog
au BufNewFile,BufRead *.zsh-theme         set filetype=zsh
au BufNewFile,BufRead *.snippets          set filetype=snippets
au BufNewFile,BufRead *.snippet           set filetype=snippet
au BufNewFile,BufRead .gitgot*            set filetype=yaml
au BufNewFile,BufRead .oh-my-zsh/themes/* set filetype=zsh
au BufNewFile,BufRead .gitconfig.local    set filetype=gitconfig
au BufNewFile,BufRead gitconfig.local     set filetype=gitconfig
au BufNewFile,BufRead .vagrantuser        set filetype=yaml
au BufNewFile,BufRead .aws/credentials    set filetype=dosini
au BufNewFile,BufRead *access.log*        set filetype=httplog
au BufRead,BufNewFile */.ssh/config.d/*   set filetype=sshconfig

" e.g. /etc/NetworkManager/dnsmasq.d/...
au BufNewFile,BufRead **/dnsmasq.d/*         set filetype=dnsmasq

" this usually works, but sometimes vim thinks a .t file isn't Perl
au BufNewFile,BufRead *.t set filetype=perl

" common Chef patterns
au BufNewFile,BufRead attributes/*.rb   set filetype=ruby.chef
au BufNewFile,BufRead recipes/*.rb      set filetype=ruby.chef
au BufNewFile,BufRead templates/*/*.erb set filetype=eruby.chef

" FIXME commenting this out, as vim-github-hub should set this for us
" " the 'hub' tool creates a number of comment files formatted in the same way
" " as a git commit message.
" autocmd BufEnter *.git/**/*_EDITMSG set filetype=gitcommit

" openvpn bundle config files
autocmd BufNewFile,BufRead *.ovpn set filetype=openvpn

autocmd BufNewFile,BufRead .tidyallrc         set filetype=dosini
autocmd BufNewFile,BufRead .perlcriticrc      set filetype=dosini
autocmd BufNewFile,BufRead .offlineimaprc     set filetype=dosini
autocmd BufNewFile,BufRead offlineimap/config set filetype=dosini
autocmd BufNewFile,BufRead offlineimap.conf   set filetype=dosini
autocmd BufNewFile,BufRead profanity/profrc   set filetype=dosini
autocmd BufNewFile,BufRead profanity/accounts set filetype=dosini

autocmd BufNewFile,BufRead fontconfig/config set filetype=xml

autocmd BufNewFile,BufRead *.org set filetype=org

autocmd BufNewFile,BufRead default/grub set filetype=sh

au BufNewFile,BufRead .config/systemd/user/**/*     set filetype=systemd

autocmd BufNewFile,BufRead pacman.d/*  set filetype=dosini
autocmd BufNewFile,BufRead pacman.conf set filetype=dosini
