" Additional setup for mail files

if exists('b:did_mail_ckw_ftplugin')
    finish
endif
let b:did_mail_ckw_ftplugin = 1

setlocal nomodeline

call rsrchboy#buffer#SetSpellOpts('mail')

setlocal foldcolumn=0

" auto-wrap paragraphs!
" set fo=a2tcqlnjr
set formatoptions+=awq

" just > for comments for now
" set comments=nb:>

" local to the buffer
set textwidth=72

setlocal backup
" setlocal patchmode='.orig'
set swapfile

" "flowed" text is going to make this go crazy, so...
let b:airline_whitespace_disabled = 1

" TODO: append to b:undo_ftplugin

if @% !~# '^/tmp/pico'

    " setlocal spell
    " autocmd InsertEnter <buffer> setlocal spell
    " autocmd InsertLeave <buffer> setlocal nospell

    finish
endif

" These commands are only executed if we're in a message edit buffer.

" turn on spell-check
setlocal spell

" JUST KEEP SAVING IT OK??
" autocmd CursorHold <buffer> update
" autocmd TextChanged,TextChangedI <buffer> update
" autocmd TextChanged <buffer> update

normal! gg0
startinsert
