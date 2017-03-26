" These are our custom dzil/pw POD commands.

syn match podCommand "^=func"    nextgroup=podCmdText
syn match podCommand "^=method"  nextgroup=podCmdText
syn match podCommand "^=attr"    nextgroup=podCmdText
syn match podCommand "^=lazyatt" nextgroup=podCmdText
syn match podCommand "^=reqatt"  nextgroup=podCmdText
syn match podCommand "^=genatt"  nextgroup=podCmdText
syn match podCommand "^=type"    nextgroup=podCmdText
syn match podCommand "^=test"    nextgroup=podCmdText
