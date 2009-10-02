" Syntax highlight scheme
colorscheme desert
" Turn on filetype plugin
" filetype on
filetype plugin on
filetype indent on

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

" Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

" Uppercase commands shortcuts
cab W w
cab Q q
cab WQ wq
cab Wq wq
cab wQ wq

" Map cut, copy and paste to leader-based shortcuts to avoid conflicts with
" existing commands
vnoremap <Leader>x "+x
vnoremap <Leader>c "+ygv
map <Leader>v "+gP

