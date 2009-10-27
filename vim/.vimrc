" Change Leader key
let mapleader=','

" Change syntax highlight scheme for GUI
" and set a dark background for console
if has('gui_running')
	colorscheme desert
else
	set background=dark
endif

" Turn on filetype plugin
filetype on
filetype plugin on
filetype indent on
" Enable Django python snippets
autocmd FileType python set ft=python.django
" Enable snippets for Django HTML templates
au BufRead,BufNewFile *.html set filetype=html.django_template

" Enable modelines
set modeline

" Hide pyc files and hidden files in file explorer
let g:netrw_list_hide='^\.[^\.],\.pyc$'

" Default indenting: hard-tabs, 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab autoindent
" Line numbering
set nu
" Incremental search
set incsearch
" Wrap at words
set lbr
" Highlight the current line
set cursorline

" Scroll to the middle of the screen when searching
map n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

" Use bufkill.vim plugin to close buffers and keep windows
cab bd BD
cab bu BU

" Setup whitespace
set listchars=tab:»·,trail:·,eol:¶

" Uppercase commands shortcuts
cab W w
cab Q q
cab WQ wq
cab Wq wq
cab wQ wq

" Move lines up and down with Alt+J and Alt+k
" From: http://vim.wikia.com/wiki/Moving_lines_up_or_down_in_a_file
nnoremap <C-j> mz:m+<CR>`z==
nnoremap <C-k> mz:m-2<CR>`z==
inoremap <C-j> <Esc>:m+<CR>==gi
inoremap <C-k> <Esc>:m-2<CR>==gi
vnoremap <C-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <C-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z

" Map system clipboard cut, copy and paste to leader-based shortcuts
map <Leader>x V"+x
map <Leader>c V"+y
map <Leader>v "+gP
vnoremap <Leader>x "+ygvd
vnoremap <Leader>c "+ygv

" Set permissions for bash scripts
au BufWritePost *.sh silent execute "!chmod a+x <afile>"
" Automatically give executable permission to scripts starting with #!/bin/sh
au BufWritePost * if getline(1) =~ "^#!/bin/[a-z]*sh" | silent execute "!chmod a+x <afile>" | endif
