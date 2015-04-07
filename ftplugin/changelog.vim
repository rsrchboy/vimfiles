" Additional setup for changelog files

if exists("b:did_changelog_ckw_ftplugin")
    finish
endif
let b:did_changelog_ckw_ftplugin = 1

" Turn on spellcheck for changelogs
setlocal spell
setlocal spelllang=en_us
setlocal spellcapcheck=0
setlocal spellfile+=~/.vim/spell/changelog.utf-8.add

setlocal foldcolumn=0
