au BufNewFile,BufRead apparmor.d/*               setfiletype apparmor
au BufNewFile,BufRead *.cson                     setfiletype coffee
au BufNewFile,BufRead ansible/**/files/sshkeys/* setfiletype sshauthkeys
au BufNewFile,BufRead .gitpan                    setfiletype yaml
au BufNewFile,BufRead *.psgi                     setfiletype perl
au BufNewFile,BufRead cpanfile                   setfiletype perl
au BufNewFile,BufRead alienfile                  setfiletype perl
au BufNewFile,BufRead Rexfile                    setfiletype perl
au BufNewFile,BufRead *.tt                       setfiletype tt2html
au BufNewFile,BufRead *.tt2                      setfiletype tt2html
au BufNewFile,BufRead Changes                    setfiletype changelog
au BufNewFile,BufRead *.zsh-theme                setfiletype zsh
au BufNewFile,BufRead *.snippets                 setfiletype snippets
au BufNewFile,BufRead *.snippet                  setfiletype snippet
au BufNewFile,BufRead .gitgot*                   setfiletype yaml
au BufNewFile,BufRead .oh-my-zsh/themes/*        setfiletype zsh
au BufNewFile,BufRead .gitconfig.local           setfiletype gitconfig
au BufNewFile,BufRead gitconfig.local            setfiletype gitconfig
au BufNewFile,BufRead .vagrantuser               setfiletype yaml
au BufNewFile,BufRead .aws/credentials           setfiletype dosini
au BufNewFile,BufRead *access.log*               setfiletype httplog
au BufNewFile,BufRead */.ssh/config.d/*          setfiletype sshconfig
au BufNewFile,BufRead **/dnsmasq.d/*             setfiletype dnsmasq
au BufNewFile,BufRead *.t                        setfiletype perl
au BufNewFile,BufRead attributes/*.rb            setfiletype ruby.chef
au BufNewFile,BufRead recipes/*.rb               setfiletype ruby.chef
au BufNewFile,BufRead templates/*/*.erb          setfiletype eruby.chef
au BufNewFile,BufRead *.ovpn                     setfiletype openvpn
au BufNewFile,BufRead .tidyallrc                 setfiletype dosini
au BufNewFile,BufRead .perlcriticrc              setfiletype dosini
au BufNewFile,BufRead .offlineimaprc             setfiletype dosini
au BufNewFile,BufRead **/offlineimap/config      setfiletype dosini
au BufNewFile,BufRead offlineimap.conf           setfiletype dosini
au BufNewFile,BufRead profanity/profrc           setfiletype dosini
au BufNewFile,BufRead profanity/accounts         setfiletype dosini
au BufNewFile,BufRead fontconfig/config          setfiletype xml
au BufNewFile,BufRead *.org                      setfiletype org
au BufNewFile,BufRead default/grub               setfiletype sh
au BufNewFile,BufRead .config/systemd/user/**/*  setfiletype systemd
au BufNewFile,BufRead pacman.d/*                 setfiletype dosini
au BufNewFile,BufRead pacman.conf                setfiletype dosini
au BufNewFile,BufRead *.terminfo                 setfiletype terminfo

" FIXME commenting this out, as vim-github-hub should set this for us
" " the 'hub' tool creates a number of comment files formatted in the same way
" " as a git commit message.
" autocmd BufEnter *.git/**/*_EDITMSG set ft=gitcommit
