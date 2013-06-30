" Vim support file to detect apparmor files
"
" Maintainer: Chris Weyl <cweyl@alumni.drew.edu> 2013

au BufNewFile,BufRead apparmor.d/* set filetype=apparmor
