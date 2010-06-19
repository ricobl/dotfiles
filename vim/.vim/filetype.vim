" markdown filetype file
if exists("did\_load\_filetypes")
	finish
endif

" Set permissions for bash scripts
au BufWritePost *.sh silent execute "!chmod a+x <afile>"
" Automatically give executable permission to scripts starting with #!/bin/sh
au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | silent execute "!chmod a+x <afile>" | endif

" Enable pysmell plugin
au FileType python setlocal omnifunc=pysmell#Complete

" Markdown syntax
augroup markdown
	au! BufRead,BufNewFile *.mkd   setfiletype mkd
	au! BufRead,BufNewFile *.md   setfiletype mkd
augroup END

