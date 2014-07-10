execute pathogen#infect()
syntax on
filetype plugin indent on

"WARNING
"
"GUI specific options are in ~/.gvimrc
colorscheme desert
        

" -------------------------------------------------------- General
" don't bother about VI compatibility
set nocompatible
" avoid 'Hit return to continue' message
set shortmess=a
" No annoying beeps: use visualbell
set vb

" -------------------------------------------------------- Source display
" no tabs! spaces only
set expandtab
" tabspace to 2 spaces
set ts=2
" No linefeed forced ever
set tw=0
" and wrap at the end of window (no horizontal scrollbar)
set wrap
" Unix files
set fileformat=unix
" do not allow actual rendering of html tags content
let html_no_rendering=1
" ident control
set autoindent
set smartindent
set shiftwidth=2
" I want to see matching parenthesis
set showmatch
" backspace control
set bs=indent,eol,start
" automatic syntax coloring
if version >= 600
	syntax enable
else	
	set syntax=on
endif	

" ----------------------------------------------- status line
" also see colorscheme in tgo.vim
" status line looks like
" filename modified readonly type buffernum,modified line,column percentinfile hexofcharundercursor
set statusline=%-5t%-1m%r%y%=[%n%M]\ %l,%c\ %p%%\ 0x%B
set laststatus=2


" ----------------------------------------------- default folding behaviour
if (v:version >= 600)
	" we want simple block folding by indent
	set foldmethod=indent
	set foldlevel=1
endif

" -------------------------------------------------------- Searching
" search incrementaly and smartly 
set smartcase
set incsearch
" highlight search results
set hlsearch
" 																	!!! REMEMBER the * key searches for whatever is under the cursor
"

" -------------------------------------------------------- CtrlP plugin
" ctrlp limits
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40

" ------------------------------------------------------- Programming
" for correct ctags and cscope handling (alternative is required
" in case there is already a file/directory names tags or ctags
" additional names could be added if both names exits
let $WDIR=getcwd() "get the working directory
if has("unix") 
	set tags=$WDIR/tags
endif
"setup scope info only is available
if has("cscope")
	let cscope=filereadable("$WDIR/cscope.out")
	if exists("cscope")
		set csprg=/usr/local/bin/cscope "direct path
		set csto=1 "seach scope before ctags
		set cst
		set nocsverb
		cs add $WDIR/cscope.out
		set csverb
	endif
endif
" ------------------------------------------------------- Scripts
"source ~tgo/personnel/vim/matchit.vim
let g:calendar_weeknm = 1 " WK01

" ------------------------------------------------------ Key Maps
map <F3> n
map <S-F3> [I
map <F4> :nohl<CR>

" ,e/,w to open/save a file in the same directory as the currently edited file
if has("unix")
	map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
	map ,w :w <C-R>=expand("%:p:h") . "/" <CR>
	map ,r :r <C-R>=expand("%:p:h") . "/" <CR>
	" ,f creates a filesystem tree starting at the current directory
	map ,f :exe CreateMenuPath(expand("%:p:h"),"Tgo&Path") <CR>
else
	map ,e :e <C-R>=expand("%:p:h") . "\\"<CR> 
	map ,w :w <C-R>=expand("%:p:h") . "/" <CR>
	map ,r :r <C-R>=expand("%:p:h") . "/" <CR>
endif
" use CTRL-UP & CTRL-DOWN & CTRL-= to manage folds
map <C-UP> zc
map <C-DOWN> zO
map <C-PAGEUP> :Df 0<CR>
map <C-S-PAGEUP> :Df 1<CR>
map <C-PAGEDOWN> zR
" use CTRL-RIGHT & CTRL-LEFT to move between buffers
map <C-RIGHT> :bn<CR>
map <C-LEFT> :bp<CR>
