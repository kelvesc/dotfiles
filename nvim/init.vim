" NeoVim Configuration

" General
set scrolloff=8
syntax on
filetype on
set number
set ruler
set relativenumber
set autoread            "Auto reads file when file changes
set lazyredraw          "Don't redraw while processing macros
set nocursorline        "Draws a line where the cursor is located
set mouse=a             "Mouse behavior set to ALL
set history=500
set cmdheight=1
set background=dark
set wildmenu            "Completion wnabled
set wildmode=list:full  "Show a list when completing

"Editing
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set textwidth=80
set colorcolumn=81
set autoindent
set smartindent
set breakindent
set clipboard=unnamed

set modelines=0
set linebreak           "Break long lines to fit the terminal size
let &showbreak = "+ "   "Broken lines are denoted by
set autoindent
set smartindent
set wrap

"Tab behavior
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set backspace=indent,eol,start "Backspace behavior
set whichwrap+=<,>,h,l

"Searching
set hlsearch            "Highlight search results
set ignorecase          "Make the search case insensitive
set smartcase           "Smart about cases when searching
set incsearch           "Incremental search
set synmaxcol=80        "Don't search in long lines
set magic               "For regular expressions

set showmatch           "Show matching { [ ( ) ] }
set foldenable          "enable folding
set foldcolumn=0        "Add a margin to the left
set foldmethod=manual

set splitbelow          "Horizontal split is below
set splitright          "Vertical split is right
set laststatus=2        "Always show the status line

"Autocommands
augroup vimrc
    autocmd!
    autocmd BufWinEnter,Syntax * syn sync minlines=500 maxlines=500
augroup END
"Autosaves when focus is lost
autocmd FocusLost * :wa
autocmd FocusGained,BufEnter * checktime
autocmd BufReadPost * :call ReturnLastPosition()
autocmd Filetype haskell,vhdl,ada call HSSyntax()
autocmd Filetype c,cpp call CSyntax()
autocmd Filetype sh,make,python call ScriptSyntax()
autocmd Filetype erlang call ErlangSyntax()
autocmd Filetype ml,sml call MLSyntax()

"Functions
function! SpellCheck() abort
    setlocal spell spelllang=en_us
    setlocal noexpandtab
endfunction

function! CancelSpellCheck() abort
    setlocal nospell
    setlocal expandtab
endfunction

function! ReturnLastPosition() abort
    if line("'\"") > 1 && line("'\"") <= line("$")
        execute "normal! g'\""
    endif
endfunction

function! HSSyntax() abort
    map <silent> <F2> :s/^/--/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^--//<CR>:nohlsearch<CR>
endfunction

function! EasyC() abort
    map <silent> <F2> :s/^/\/\//<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^\/\///<CR>:nohlsearch<CR>
endfunction

function! ScriptSyntax() abort
    map <silent> <F2> :s/^/#/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^#//<CR>:nohlsearch<CR>
endfunction

function! ErlangSyntax() abort
    map <silent> <F2> :s/^/%/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^%//<CR>:nohlsearch<CR>
    inoremap ,, ->
endfunction

function! MLSyntax() abort
    map <silent> <F2> :s/^/(*/<CR>:s/$/*)/<CR>:nohlsearch<CR>
    map <silent> <F4> :s/^(*//<CR>:s/*)$/ /<CR>:nohlsearch<CR>
    inoremap ,, =>
endfunction

function! Comment() abort
    if &filetype == "vim"
        map <silent> <Leader>1 :s/^/" /<CR>:nohlsearch<CR>
        map <silent> <Leader>2 :s/^" //<CR>:nohlsearch<CR>
        map <silent> <F2> :s/^/" /<CR>:nohlsearch<CR>
        map <silent> <F4> :s/^" //<CR>:nohlsearch<CR>
    elseif &filetype == "haskell"
        map <silent> <F2> :s/^/-- /<CR>:nohlsearch<CR>
        map <silent> <F4> :s/^-- //<CR>:nohlsearch<CR>
    endif
endfunction

"Abbreviations
abbr todo TODO:
abbr tood TODO:
abbr fixm FIXME:
abbr fxme FIXME:
abbr tehn then
abbr lese else
abbr caes case
abbr ceas case

"Mappings
"let leader
let mapleader = ","
"Remaps F1 to ESC in all modes
noremap <F1> <ESC>
"Fix regex search by inserting \v at the begining
nnoremap / /\v
vnoremap / /\v
"Map Shift-h to lines begining and Shift-l to lines end
nnoremap H 0
vnoremap H 0
nnoremap L $
vnoremap L $
"Tab places the cursor at matching bracket
nnoremap <tab> %
vnoremap <tab> %
"Easier access to ( and )
inoremap ~  (
inoremap ^ )
"Ctrl-s saves the file, in any mode
inoremap <C-s> <ESC>:w<CR>
nnoremap <C-s> <ESC>:w<CR>
vnoremap <C-s> <ESC>:w<CR>
"Maps qq to quit
inoremap qq <ESC>:q<CR>
nnoremap qq <ESC>:q<CR>
vnoremap qq <ESC>:q<CR>
"QQ to force quit
nnoremap QQ <ESC>:q!<CR>
"Remaps jj to ESC, in INSERT MODE
inoremap jj <ESC>
"Deactivates highlighted search
noremap <silent> <C-h> :nohlsearch<CR>
"Strip all trailing white spaces in the current file
nnoremap <leader>W :%s/\s/+$//<CR>:let @/=''<CR>
"Reselect pasted text
nnoremap <leader>v V`]
"Open a vertical/horizontal split and switch over to it
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>S<C-w>k
"Reload the config file
noremap <silent> <C-l> <Esc>:source ~/.config/nvim/init.vim<CR>:nohlsearch<CR>
"TODO: figure out how folding works
nnoremap <F3> za
nnoremap <Space> za
vnoremap <Space> za
inoremap <F3> <C-O>za
"TODO: make some ifs and remaps to easily save, compile and test code
"noremap <silent> <leader>c :s/^//<CR>:nohl<CR>
"noremap <silent> <leader>u :s/^///e<CR>:nohl<CR>
