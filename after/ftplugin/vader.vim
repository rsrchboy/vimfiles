let s:tools = {} " appease vint
execute g:rsrchboy#buffer#tools.ftplugin_guard()

" TODO should we just call scriptease#setup_vim() here?
setlocal inex=scriptease#includeexpr(v:fname)
setl kp=:help

let b:surround_64  = "@{ \r }"
let b:surround_37  = "%{ \r }"
let b:surround_36  = "${ \r }"
