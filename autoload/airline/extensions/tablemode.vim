" MIT License. Copyright (c) 2014 Mathias Andersson.
" vim: et ts=2 sts=2 sw=2
" if !exists('*tablemodeStatusline')
"   finish
" endif

function! airline#extensions#tablemode#status()
  return tablemode#IsActive() ? 'table-mode' : ''
endfunction

function! airline#extensions#tablemode#init(ext)
  call airline#parts#define_function('tablemode', 'airline#extensions#tablemode#status')
endfunction

