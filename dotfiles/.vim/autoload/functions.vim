" Disable caps when leaving insert-mode
function! functions#CapsOff()
    :silent execute "!~/bin/togglecaps.py off > /dev/null 2>&1 &"
endfunction

" Clean whitespace on save
function! functions#StripTrailingWhitespace()
    normal mZ
    %s/\s\+$//e
    if line("'Z") != line(".")
        echo "Stripped whitespace\n"
    endif
    normal `Z
endfunction

" Get current class from tagbar
function! functions#CurrentClass()
    let fullpath = tagbar#currenttag('%s', '', 'f')
    let classname = split(fullpath, '\.')[0]
    return classname
endfunction
