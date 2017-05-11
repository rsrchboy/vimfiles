" Additional setup for resolv files

if exists("b:did_resolv_ckw_ftplugin")
    finish
endif
let b:did_resolv_ckw_ftplugin = 1

" oddly, this doesn't seem to be set...
set commentstring=;%s
