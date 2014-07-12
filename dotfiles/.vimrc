" VIM 7.3 FIXES AND SETUP

let os = substitute(system('uname'), "\n", "", "")

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

" Disable some patterns on MRU list
let MRU_Exclude_Files='^COMMIT_EDITMSG$'

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

" Syntastic configuration
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_check_on_open=1
let g:syntastic_auto_loc_list=0
let g:syntastic_always_populate_loc_list=1
let g:syntastic_enable_highlighting=1
let g:syntastic_mode_map = {
            \ 'mode': 'passive',
            \ 'active_filetypes': ['puppet', 'ruby', 'python','javascript', 'css'],
            \ 'passive_filetypes': []}
let g:syntastic_quiet_messages = {'level': 'warnings'}

" Enable pathogen
call pathogen#infect()
call pathogen#helptags()

" Customize NERDTree
let NERDChristmasTree=1
let NERDTreeHijackNetrw=1
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=1

" Abbreviation for mru
cab mru Mru

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_fugitive_prefix = '⭠ '
let g:airline_readonly_symbol = '⭤'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_linecolumn_prefix = '⭡'

let g:airline_enable_tagbar = 0
let g:airline_section_x = ''
let g:airline_section_y = '%(%{get(w:,"airline_active",0) ? tagbar#currenttag("%s","", "f") : ""}%)'


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
autocmd BufRead,BufNewFile *.html.* set filetype=html.htmldjango

" Make Sass (scss) files behave like css
autocmd BufRead,BufNewFile *.scss set filetype=scss.css

" Enable python+django snippets
autocmd FileType python setlocal omnifunc=RopeCompleteFunc

" Disable preview window on auto-complete
set cot-=preview
" Close auto-complete preview window after exiting insert mode
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


if os != "Darwin"
    autocmd InsertLeave * call functions#CapsOff()
endif

" Jump to last edited position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif


" COLORS / UI

" Always show statusline
set laststatus=2

" Show lines with errors using pyflakes
highlight SpellBad term=underline gui=undercurl guisp=Orange

" Increase font size
if os == "Darwin"
    set guifont=Menlo\ Regular\ for\ Powerline:h16
else
    set guifont=Ubuntu\ Mono\ Bold\ 16
endif

" Vim / Gvim settings
if has('gui_running')
    " Set a dark background
    set background=dark
    " Change syntax highlight scheme
    colorscheme solarized
    " Remove toolbar
    set guioptions-=T
    " Maximize
    set lines=999 columns=999
else
    " Set a low timeout for commands to
    " avoid lag on console
    set ttimeoutlen=100
endif

" Disable ESC mapping
set noesckeys

" Fix gutter background
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" Setup whitespace
set listchars=tab:▸\ ,eol:¬,trail:·
hi NonText ctermfg=7 guifg=gray50
hi SpecialKey ctermfg=7 guifg=gray50

" Disable folds on opening
" autocmd Syntax * normal zR
set foldlevel=100

let g:indentLine_char = "┊"
let g:indentLine_first_char = "┊"

" Clean whitespace on save
autocmd BufWritePre * :call functions#StripTrailingWhitespace()


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
" Folding
set foldmethod=indent


" Shortcuts

" Change Leader key
let mapleader=','
" Commands with ";"
nnoremap ; :

" Toggle folds using space
nnoremap <Space> za

" Jump to the next syntastic error
nmap <silent> <Tab> :lnext<CR>
nmap <silent> <S-Tab> :lprev<CR>

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
" Make K work like k
nnoremap K k

" Insert lines and go back to normal mode
nmap <Leader>o o<ESC>
nmap <Leader>O O<ESC>

" Buffer navigation (Ctrl+Tab / Ctrl+Shift+Tab)
nnoremap <C-Tab> :tabnext<CR>
nnoremap <C-S-Tab> :tabprevious<CR>
inoremap <C-Tab> <C-O>:tabnext<CR>
inoremap <C-S-Tab> <C-O>:tabprevious<CR>

" Uppercase common commands
cab W w
cab Q q
cab WQ wq
cab Wq wq
cab wQ wq

" Tabs
cab t tabedit
nmap <Leader>t :TagbarToggle<CR>

" Toggle whitespace
nmap <Leader>w :set list!<CR>

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

" Open file under cursor (better than gf)
map <Leader>f :tab drop **/<C-r><C-f>*<CR>

" Open NERDTree
map <Leader>e :NERDTreeToggle<CR>

" Easy search and replace current word or selection
vnoremap <Leader>/ "0y/<C-r><C-0>
nnoremap <Leader>/ /<C-r><C-w>
vnoremap <Leader>? "0y?<C-r><C-0>
nnoremap <Leader>? ?<C-r><C-w>
nnoremap <Leader>s :%s/<C-r><C-w>//gc<Left><Left><Left>
vnoremap <Leader>s "0y:%s/<C-r><C-0>//gc<Left><Left><Left>
