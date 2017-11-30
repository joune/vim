execute pathogen#infect()
syntax on
filetype plugin indent on

"WARNING
"
"GUI specific options are in ~/.gvimrc
"colorscheme solarized "desert
set background=dark
colorscheme slate


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
"set fileformat=unix
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

" easy escape of nvim terminal
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif

" -- set gradle as default compiler
"  first copy https://github.com/niklasl/vimheap/blob/master/compiler/gradle.vim
"  to ~/.vim/compiler/
compiler! gradle
" F9 to launch background compilation using dispatch plugin
map <F9> :Make!<CR>
map <F10> :!gradle run<CR>

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
" ack.vim to use silversearcher-ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" -------------------------------------------------------- WildIgnore
"  patterns to ignore when searching
set wildignore+=*.so,*.swp,*.zip,*.class


" -------------------------------------------------------- Nerdtree plugin
map <F2> :NERDTreeToggle<CR>


" -------------------------------------------------------- Syntastic plugin
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
map <F12> :SyntasticToggleMode<CR>


" -------------------------------------------------------- Vim-Slime plugin
let g:slime_target = "tmux"

" -------------------------------------------------------- CtrlP plugin
" ctrlp limits
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_custom_ignore = {
 \ 'file': '\v\.(xml|html)$',
 \ }


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


" ------------------------------------------------------ read ms-Doc
"use docx2txt.pl to allow VIm to view the text content of a .docx file directly.
"http://docx2txt.sourceforge.net/
autocmd BufReadPre *.docx set ro
autocmd BufReadPost *.docx %!docx2txt.pl 
