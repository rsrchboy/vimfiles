au BufNewFile,BufRead apparmor.d/*               set ft=apparmor
au BufNewFile,BufRead *.cson                     set ft=coffee
au BufNewFile,BufRead ansible/**/files/sshkeys/* set ft=sshauthkeys
au BufNewFile,BufRead .gitpan                    set ft=yaml
au BufNewFile,BufRead *.psgi                     set ft=perl
au BufNewFile,BufRead cpanfile                   set ft=perl
au BufNewFile,BufRead alienfile                  set ft=perl
au BufNewFile,BufRead Rexfile                    set ft=perl
au BufNewFile,BufRead *.tt                       set ft=tt2html
au BufNewFile,BufRead *.tt2                      set ft=tt2html
au BufNewFile,BufRead Changes                    set ft=changelog
au BufNewFile,BufRead *.zsh-theme                set ft=zsh
au BufNewFile,BufRead *.snippets                 set ft=snippets
au BufNewFile,BufRead *.snippet                  set ft=snippet
au BufNewFile,BufRead .gitgot*                   set ft=yaml
au BufNewFile,BufRead .oh-my-zsh/themes/*        set ft=zsh
au BufNewFile,BufRead .gitconfig.local           set ft=gitconfig
au BufNewFile,BufRead gitconfig.local            set ft=gitconfig
au BufNewFile,BufRead .vagrantuser               set ft=yaml
au BufNewFile,BufRead .aws/credentials           set ft=dosini
au BufNewFile,BufRead *access.log*               set ft=httplog
au BufNewFile,BufRead */.ssh/config.d/*          set ft=sshconfig
au BufNewFile,BufRead **/dnsmasq.d/*             set ft=dnsmasq
au BufNewFile,BufRead *.t                        set ft=perl
au BufNewFile,BufRead attributes/*.rb            set ft=ruby.chef
au BufNewFile,BufRead recipes/*.rb               set ft=ruby.chef
au BufNewFile,BufRead templates/*/*.erb          set ft=eruby.chef
au BufNewFile,BufRead *.ovpn                     set ft=openvpn
au BufNewFile,BufRead .tidyallrc                 set ft=dosini
au BufNewFile,BufRead .perlcriticrc              set ft=dosini
au BufNewFile,BufRead .offlineimaprc             set ft=dosini
au BufNewFile,BufRead **/offlineimap/config      set ft=dosini
au BufNewFile,BufRead offlineimap.conf           set ft=dosini
au BufNewFile,BufRead profanity/profrc           set ft=dosini
au BufNewFile,BufRead profanity/accounts         set ft=dosini
au BufNewFile,BufRead fontconfig/config          set ft=xml
au BufNewFile,BufRead *.org                      set ft=org
au BufNewFile,BufRead default/grub               set ft=sh
au BufNewFile,BufRead .config/systemd/user/**/*  set ft=systemd
au BufNewFile,BufRead pacman.d/*                 set ft=dosini
au BufNewFile,BufRead pacman.conf                set ft=dosini
au BufNewFile,BufRead *.terminfo                 set ft=terminfo

" FIXME commenting this out, as vim-github-hub should set this for us
" " the 'hub' tool creates a number of comment files formatted in the same way
" " as a git commit message.
" autocmd BufEnter *.git/**/*_EDITMSG set ft=gitcommit
