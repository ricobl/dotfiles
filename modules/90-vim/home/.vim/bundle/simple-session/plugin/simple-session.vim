" Simple session handling
"
" Remembers last session for the current directory and restores on startup

fu! SaveSess()
  execute 'mksession! ' . getcwd() . '/.session.vim'
endfunction

fu! RestoreSess()
  if filereadable(getcwd() . '/.session.vim')
    execute 'source ' . getcwd() . '/.session.vim'
    if bufexists(1)
      for l in range(1, bufnr('$'))
        if bufwinnr(l) == -1
          exec 'sbuffer ' . l
        endif
      endfor
    endif
  endif
endfunction

" Ignore console vim because it breaks session script
if has('gui_running')
  autocmd BufRead,VimLeavePre * call SaveSess()
  autocmd VimEnter * nested call RestoreSess()
endif
