" VIM 7.3 FIXES AND SETUP

if version >= 703
    " Stop vim from complaining about split lines using \
    set nocp
    " Fixes backspace not working to dedent a line
    set backspace=indent,eol,start
    " Enable persistent undo
    set undofile
    set undodir=~/.vim/undo
    " Color columns
    set colorcolumn=80
endif

set nocompatible

" PLUGINS

" Use custom snippets dir
let snippets_dir = substitute(globpath(&rtp, 'snippets/'), "\n", ',', 'g')

" Tagbar setup
let g:tagbar_compact=1
let g:tagbar_sort=0
" Tagbar uses the CursorHold event to update active tag
" The event is triggered after 'updatetime' milliseconds
" of user inactivity.
" Decreasing the default to force quicker updates.
set updatetime=300

" Disable filetype before enabling pathogen to allow ftplugins to work
" https://github.com/tpope/vim-pathogen/issues/closed/#issue/2
filetype off

" Ropevim auto-guess project
let ropevim_guess_project=1
" Open files in tabs with RopeGotoDefinition
let g:ropevim_open_files_in_tabs=1
" Rope AutoComplete
let ropevim_vim_completion=1
let ropevim_extended_complete = 1
let g:ropevim_autoimport_modules = ["os.*", "django.*"]

" Enable pathogen
call pathogen#runtime_append_all_bundles()

" Customize NERDTree
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Abbreviation for mru
cab mru Mru


" Enable built-in matchit plugin
source $VIMRUNTIME/macros/matchit.vim


" FILETYPES

syntax on

" Turn on filetype plugin
filetype plugin on
filetype indent on

" Make all HTML files behave like Django templates
" (vim's auto-detection fails sometimes)
autocmd BufRead,BufNewFile *.html set filetype=html.htmldjango

" Enable python+django snippets
" autocmd FileType python set ft=python.django
autocmd BufRead,BufNewFile *.py set filetype=python.django
autocmd FileType python setlocal omnifunc=RopeCompleteFunc
" Disable preview window on auto-complete
set cot-=preview
" Close auto-complete preview window after exiting insert mode
" autocmd InsertLeave * if pumvisible() == 0|pclose|endif



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
" Always show statusline
set laststatus=2
" Format status line (tagbar | line,col)
set statusline=
set statusline+=%{tagbar#currenttag('%s','','fs')}
set statusline+=%=
set statusline+=%l,%c

" Set a dark background
set background=dark
" Show lines with errors using pyflakes
highlight SpellBad term=underline gui=undercurl guisp=Orange 

" Increase font size
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    set guifont=Menlo\ Regular:h14
else
    set guifont=Ubuntu\ Mono\ Bold\ 14
endif

" Vim / Gvim settings
if has('gui_running')
    " Change syntax highlight scheme
    colorscheme solarized
    " Remove toolbar
	set guioptions-=T
else
    " Set a low timeout for commands to
    " avoid lag on console
	set ttimeoutlen=100
endif

" Setup whitespace
set listchars=tab:▸\ ,eol:¬,trail:·
hi NonText ctermfg=7 guifg=gray50
hi SpecialKey ctermfg=7 guifg=gray50

" Font
let &guifont = substitute(&guifont,':h\zs\d\+', '\=eval(submatch(0)+2)', '')


" OPTIONS

" Improve block selection by allowing selection of empty spaces
set virtualedit+=block

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
" Round indentation to be multiple of shiftwidth
set shiftround
" Line numbers, incremental search, highlight current line, word-wrap
set number incsearch cursorline linebreak
" Smart case search
set ignorecase
set smartcase
" Disable smartcase for auto-completion
" and enable for searching
autocmd InsertEnter * set noic
autocmd InsertLeave * set ic
" Keep some visible lines when scrolling
set scrolloff=5


" Shortcuts

" Change Leader key
let mapleader=','
" Commands with ";"
nnoremap ; :

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
nmap 0 ^
" Make D erase the rest of the line
nnoremap D d$

" Insert lines and go back to normal mode
nmap <Leader>o o<ESC>
nmap <Leader>O O<ESC>

" Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
inoremap <C-Tab> :tabnext<CR>
inoremap <C-S-Tab> :tabprevious<CR>
nmap <SwipeLeft> :tabprevious<CR>
nmap <SwipeRight> :tabnext<CR>

" Use swipe to jump to BOF / EOF
nmap <SwipeUp> gg
nmap <SwipeDown> G

" Uppercase common commands
cab W w
cab Q q
cab WQ wq
cab Wq wq
cab wQ wq

" Tabs
cab t tabedit
nmap <Leader>t :TagbarToggle<CR>


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

" Easier auto-completion
imap <c-space> <C-X><C-O>

" Rope shortcuts
map <Leader>d :RopeGotoDefinition<CR>
map <Leader>g :RopeGenerateFunction<CR>
map <Leader>a :RopeAutoImport<CR>
map <Leader>r :RopeRename<CR>
imap <c-space> <C-R>=RopeCodeAssistInsertMode()<CR>

" Open file under cursor (better than gf)
map <Leader>f :n **/<C-r><C-f><CR>:tab sball<CR>:tabprev<CR>

" Open NERDTree
map <Leader>e :NERDTreeToggle<CR>

" Easy replace current word / selection
nnoremap <Leader>/ :%s/<C-r><C-w>//g<Left><Left>
vnoremap <Leader>/ y:%s/<C-r><C-">//g<Left><Left>

