let s:tools = g:rsrchboy#buffer#tools

call s:tools.nnore2map('q', ':close<CR>')

" lookups, etc.  Brings us in line with the `perl` ft
setl iskeyword+=:
