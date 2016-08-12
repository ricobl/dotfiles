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

" Git branch
function! functions#GitBranch()
    if !exists('g:git_branch')
        call functions#UpdateGitBranch()
    endif

    return g:git_branch
endfunction

" Updates current git branch
function! functions#UpdateGitBranch()
    let g:git_branch = system("git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* //'")
    if g:git_branch != ''
        let g:git_branch = substitute(g:git_branch, '\n', '', 'g')
    endif
endfunction

function! functions#Tabedit(...)
    let t = tabpagenr()
    let i = 0
    for f in a:000
        let matches = glob(f, 0, 1)
        if len(matches) > 0
            for g in matches
                exe "tabe " . fnameescape(g)
                let i = i + 1
            endfor
        else
            exe "tabe " . fnameescape(f)
        endif
    endfor
    if i
        exe "tabn " . (t + 1)
    endif
endfunction
