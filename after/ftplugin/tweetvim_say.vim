" Additional setup for tweetvim_say files

if exists('b:did_tweetvim_say_ckw_ftplugin')
    finish
endif
let b:did_tweetvim_say_ckw_ftplugin = 1

" Buffer Options: {{{1

setlocal nohlsearch
setlocal spell

setlocal nowrap
