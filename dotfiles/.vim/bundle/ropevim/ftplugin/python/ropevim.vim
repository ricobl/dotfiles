" Enable ropevim

let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    source /System/Library/Frameworks/Python.framework/Versions/2.6/ropevim.vim
else
    source /usr/local/ropevim.vim
endif
