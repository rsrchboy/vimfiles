" A couple mail syntax tweaks
"
" Author: Chris Weyl <cweyl@alumni.drew.edu> 2015

" turn off spell checking in mail sigs -- note the addition of ",@NoSpell" is
" the only difference from the stock line...  this makes me wish I knew some
" way to just append to a syntax region's "contains" list
syn region mailSignature keepend contains=@mailLinks,@mailQuoteExps,@NoSpell start="^--\s$" end="^$" end="^\(> \?\)\+"me=s-1 fold

