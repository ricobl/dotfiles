" PLUGINS

" Use custom snippets dir
let snippets_dir = substitute(globpath(&rtp, 'snippets/'), "\n", ',', 'g')

" Disable filetype before enabling pathogen to allow ftplugins to work
" https://github.com/tpope/vim-pathogen/issues/closed/#issue/2
filetype off

" Enable pathogen
call pathogen#runtime_append_all_bundles()


" FILETYPES

" Turn on filetype plugin
filetype plugin on
filetype indent on

" Make all HTML files behave like Django templates
" (vim's auto-detection fails sometimes)
autocmd BufRead,BufNewFile *.html set filetype=html.htmldjango

" Enable python+django snippets
autocmd FileType python set ft=python.django

" Set ruby filetype for lettuce/cucumber features and pyccuracy actions
au! BufRead,BufNewFile *.feature setfiletype ruby
au! BufRead,BufNewFile *acc setfiletype ruby

" Disable caps when leaving insert-mode
function! CapsOff()
    :silent execute "!~/bin/togglecaps.py off > /dev/null 2>&1 &"
endfunction
autocmd InsertLeave * call CapsOff()

" Jump to last edited position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" COLORS / UI

" Make status-line fade on inactive windows
highlight StatusLine ctermfg=black ctermbg=green cterm=NONE
highlight StatusLineNC ctermfg=black ctermbg=lightblue cterm=NONE

" Vim / Gvim settings
if has('gui_running')
    " Change syntax highlight scheme for GUI
	colorscheme desert
	set guioptions-=T  "remove toolbar
    " Show lines with errors using pyflakes
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
else
    " Set a dark background for console
	set background=dark
    " Set a low timeout for commands to
    " avoid lag on console
	set ttimeoutlen=100
endif

" Setup whitespace
"set listchars=tab:»·,trail:·,eol:¶
set listchars=tab:▸\ ,eol:¬,trail:·
hi NonText ctermfg=7 guifg=gray50 guibg=gray20
hi SpecialKey ctermfg=7 guifg=gray50 guibg=gray20


" OPTIONS

" Disable backup and swap files
set nobackup noswapfile
" Enable modelines
set modeline

" Enable bash-like completion: complete, show list, cycle
set wildmenu wildmode=longest,list,full 
" Disable file formats from wild-list
set wildignore=*.pyc,*.gif,*.png,*.jpg,*.jpeg
" Hide pyc files and hidden files in file explorer
let g:netrw_list_hide='^\.[^\.],\.pyc$'

" Default indenting: soft-tabs, 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab autoindent
" Line numbers, incremental search, highlight current line, word-wrap
set number incsearch cursorline linebreak

" Shortcuts

" Change Leader key
let mapleader=','
" Commands with ";"
nnoremap ; :

" Keep some visible lines when scrolling
set scrolloff=5
" Scroll to the middle of the screen when searching
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
" Leave cursor where it was
set nostartofline
" Make 0 work like ^, easier on US Keyboards
map 0 ^

" Insert lines and go back to normal mode
nmap <Leader>o o<ESC>
nmap <Leader>O O<ESC>

" Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprevious<CR>

" Uppercase common commands
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

" Use Esc instead of opening the help
nnoremap <F1> <Esc>
inoremap <F1> <Esc>
vnoremap <F1> <Esc>

