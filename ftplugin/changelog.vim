" Additional setup for changelog files

if exists("b:did_changelog_ckw_ftplugin")
    finish
endif
let b:did_changelog_ckw_ftplugin = 1

" Turn on spellcheck for changelogs
setlocal spell spelllang=en_us spellcapcheck=0
