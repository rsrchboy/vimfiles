
" snippet language syntax highlighting

if fnamemodify(@%, ':t:r') ==# 'vim'
    echom 'found vim!'

    " let s:cs = b:current_syntax
    " unlet b:current_syntax
    " syntax include @Viml syntax/vim.vim
    " let b:current_syntax = s:cs

    syn region snipSnippetBody start="\_." end="^\zeendsnippet\s*$" contained nextgroup=snipSnippetFooter contains=snipLeadingSpaces,@snipTokens,@Viml
else
    echom 'found: ' . fnamemodify(@%, ':t:r')
endif



