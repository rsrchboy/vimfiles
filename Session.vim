let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.vim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +56 vimrc
badd +112 README.md
badd +1 blah.csv
badd +1 bundle/systemd-vim-syntax/ftdetect/systemd.vim
badd +1 bundle/Dockerfile.vim/ftdetect/Dockerfile.vim
badd +1 bundle/interfaces/ftdetect/interfaces.vim
badd +2 bundle/puppet-syntax-vim/ftdetect/puppet.vim
badd +7 after/plugin/colorscheme.vim
badd +16 .git/COMMIT_EDITMSG
badd +1795 bundle/.neobundle/doc/neobundle.txt
badd +3211 /usr/share/vim/vim74/doc/eval.txt
badd +1 \[tweetvim]
argglobal
silent! argdel *
edit bundle/.neobundle/doc/neobundle.txt
set splitbelow splitright
set nosplitbelow
wincmd t
set winheight=1 winwidth=1
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=1
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 1795 - ((36 * winheight(0) + 27) / 54)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1795
normal! 0
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
