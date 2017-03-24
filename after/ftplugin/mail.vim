" Additional setup for mail files

if exists("b:did_mail_ckw_ftplugin")
    finish
endif
let b:did_mail_ckw_ftplugin = 1

setlocal nomodeline

" turning on spell is handled down below
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/mail.utf-8.add

setlocal foldcolumn=0

" auto-wrap paragraphs!
" set fo=a2tcqlnjr
set fo+=awq

" just > for comments for now
" set comments=nb:>

" local to the buffer
set tw=72

setlocal backup
set swapfile

" "flowed" text is going to make this go crazy, so...
let b:airline_whitespace_disabled = 1

" TODO: append to b:undo_ftplugin

if @% !~# '^/tmp/pico'

    " We're not editing mail to send via pine, but that doesn't mean we're not
    " sending mail from somewhere.  Don't turn spell on unconditonally, just
    " if we enter insert mode.
    autocmd InsertEnter <buffer> setlocal spell
    autocmd InsertLeave <buffer> setlocal nospell

    finish
endif

" echom

" These commands are only executed if we're in a message edit buffer.

" turn on spell-check
setlocal spell

" JUST KEEP SAVING IT OK??
" autocmd CursorHold <buffer> update
" autocmd TextChanged,TextChangedI <buffer> update
autocmd TextChanged <buffer> update

normal gg0
startinsert
