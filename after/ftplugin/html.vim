" a couple additional settings for html type buffers

let s:tools = {}
execute g:rsrchboy#buffer#tools.ftplugin_guard('html')

call s:tools.setno('wrap')
call s:tools.setplus('iskeyword', '-')

unlet s:tools
" __END__
