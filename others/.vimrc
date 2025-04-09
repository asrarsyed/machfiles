""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"               
"               ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"               ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"               ██║   ██║██║██╔████╔██║██████╔╝██║     
"               ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║     
"                ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"                 ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"               
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible " Use VIM settings rather than Vi settings; this *must* be first in .vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GENERAL SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent           " copy indent from the current line when starting a new line
set backspace=2          " allow backspacing over everything in insert mode
set history=50           " keep 50 lines of command line history
set ignorecase           " search commands are case-insensitive
set hlsearch 			 "highlights search terms"
set incsearch            " while typing a search command, show matches incrementally instead of waiting for you to press enter

set mouse=a              " enable mouse interaction
set number               " line numbers at the side
set ruler                " show the cursor position all the time
set shiftwidth=4         " pressing >> or << in normal mode indents by 4 characters
set tabstop=4            " a tab character indents to the 4th (or 8th, 12th, etc.) column
set encoding=utf8        " non-ascii characters are encoded with UTF-8 by default
set noexpandtab          " pressing the tab key creates a tab character, not spaces
set formatoptions=croq   " c=autowrap comments, r=continue comment on <enter>, o=continue comment on o or O, q=allow format comment with g

set textwidth=0          " no forced wrapping in any file type (unless overridden)
set showcmd              " show length of visual selection (docs recommended keeping this off when working over slow connections)

set complete=.,w,b,u     " make autocomplete faster - http://www.mail-archive.com/vim@vim.org/msg03963.html
set splitright           " create vertical splits to the right
set splitbelow           " create horizontal splits below

set switchbuf=usetab     " when switching buffers, include tabs
set tabpagemax=30        " show up to 30 tabs

set clipboard=unnamed,unnamedplus
set cryptmethod=blowfish " use blowfish encryption for encrytped files
let g:netrw_mouse_maps=0 " Ignore mouse clicks when browsing directories

syntax on                " Enable syntax highlighting.

" Set viminfo options for history and registers
set viminfo='20,\"50

" Set the location for the viminfo file (use the full path here)
set viminfo+=n~/.cache/.viminfo


set background=dark
colorscheme habamax
