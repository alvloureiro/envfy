"
"===================================================================================
" GENERAL SETTINGS
"===================================================================================

" disable the fcking beep
set vb t_vb=

"-------------------------------------------------------------------------------
" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
"-------------------------------------------------------------------------------
set nocompatible
"
"-------------------------------------------------------------------------------
" Enable file type detection. Use the default filetype settings.
" Also load indent files, to automatically do language-dependent indenting.
"-------------------------------------------------------------------------------
filetype plugin on
filetype indent on

"
"
"
if has("autocmd")
	autocmd BufNewFile,BufRead *.qml,*.qmlproject set filetype=qml
endif " has("autocmd")

"""
""" Highlighting that moves with the cursor
"""
set cursorline

"
"-------------------------------------------------------------------------------
" Switch syntax highlighting on.
"-------------------------------------------------------------------------------
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
endif

"
"-------------------------------------------------------------------------------
" change the comment color to cyan
"-------------------------------------------------------------------------------
"highlight Comment ctermfg=cyan
set background=dark

"
" Using a backupdir under UNIX/Linux: you may want to include a line similar to
"   find  $HOME/.vim.backupdir -name "*" -type f -mtime +60 -exec rm -f {} \;
" in one of your shell startup files (e.g. $HOME/.profile)
"
" - central backup directory (has to be created)
set backupdir =$HOME/.vim.backupdir

"-------------------------------------------------------------------------------
" Various settings
"-------------------------------------------------------------------------------
set autoindent                  " copy indent from current line
set autoread                    " read open files again when changed outside Vim
set autowrite                   " write a modified buffer on each :next , ...
set backspace=indent,eol,start  " backspacing over everything in insert mode
set backup                      " keep a backup file
set browsedir=current           " which directory to use for the file browser
set complete+=k                 " scan the files given with the 'dictionary' option
set history=50                  " keep 50 lines of command line history
set hlsearch                    " highlight the last used search pattern
set incsearch                   " do incremental searching
"set ignorecase                  " Ignore case when searching.
set smartcase                   " case-sensitive if search contains an uppercase character
set listchars=tab:>.,eol:\$     " strings to use in 'list' mode
"set mouse=a                     " enable the use of the mouse
"set nowrap                      " do not wrap lines
set popt=left:8pc,right:3pc     " print options
set ruler                       " show the cursor position all the time
set shiftwidth=4                " number of spaces to use for each step of indent
set showcmd                     " display incomplete commands
set showmode                    " Show editing mode
set smartindent                 " smart autoindenting when starting a new line
set tabstop=4                   " number of spaces that a <Tab> counts for
"set visualbell                  " visual bell instead of beeping
set wildignore=*.bak,*.o,*.e,*~ " wildmenu: ignore these extensions
set wildmenu                    " command-line completion in an enhanced mode
set encoding=utf-8              " Use UTF-8.
set showmatch
set scrolloff=5                 " always have some lines of text when scrolling

set clipboard=unnamed
"let @*=@a

set splitright

set completeopt=longest,menuone

"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=[%{&ff}]\ [%Y]\ [pos:%04l,%04v][%p%%]\ [len:%L]\ %<%F%m%r%h%w
"set statusline=[FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ %F%m%r %#StatusLineNC#\ Git\ %#ErrorMsg#\ %{GitBranchInfoTokens()[0]}\ %#StatusLine#
set laststatus=2
"===================================================================================
" BUFFERS, WINDOWS
"===================================================================================
"
"-------------------------------------------------------------------------------
" The current directory is the directory of the file in the current window.
"-------------------------------------------------------------------------------
"if has("autocmd")
"  autocmd BufEnter * :lchdir %:p:h
"endif
"
"-------------------------------------------------------------------------------
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
"-------------------------------------------------------------------------------
if has("autocmd")
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
endif " has("autocmd")
"
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
" inoremap ( ()<Left>
" inoremap [ []<Left>
" inoremap { {}<Left>
" "
" vnoremap ( s()<Esc>P<Right>%
" vnoremap [ s[]<Esc>P<Right>%
" vnoremap { s{}<Esc>P<Right>%
"
"-------------------------------------------------------------------------------
" autocomplete quotes (visual and select mode)
"-------------------------------------------------------------------------------
"xnoremap  '  s''<Esc>P<Right>
"xnoremap  "  s""<Esc>P<Right>
"xnoremap  `  s``<Esc>P<Right>
"
"===================================================================================
" VARIOUS PLUGIN CONFIGURATIONS
"===================================================================================
"
"-------------------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for make
" taglist.vim : define the title texts for qmake
"-------------------------------------------------------------------------------
noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'

if has("autocmd")
	" ----------  qmake : set filetype for *.pro  ----------
	autocmd BufNewFile,BufRead *.pro,*.pri  set filetype=qmake
endif " has("autocmd")


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
"    Enable folding, but by default make it act like folding is off, because
"    folding is annoying in anything but a few rare cases
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldenable " Turn on folding
set foldmethod=indent " Make folding indent sensitive
set foldlevel=100 " Don't autofold anything (but I can still fold manually)
set foldopen-=search " don't open folds when you search into them
set foldopen-=undo " don't open folds when you undo stuff


"""
""" rest
"""
set formatoptions+=tqn
set formatlistpat=^\\s*\\(\\d\\+\\\|[a-z]\\)[\\].)]\\s*
set formatoptions+=tqn

"""
""" automatically remove trailing whitespace before write
"""
function! StripTrailingWhitespace()
  normal mZ
  %s/\s\+$//e
  if line("'Z") != line(".")
    echo "Stripped whitespace\n"
  endif
  normal `Z
endfunction
"autocmd BufWritePre * :call StripTrailingWhitespace()
"autocmd BufEnter * :call StripTrailingWhitespace()

"""
"""
"""
set list listchars=tab:»·,trail:·

if has("autocmd")
	" Extra syntax
	hi ErrorSpace cterm=NONE ctermfg=black   ctermbg=red
	hi Error99    cterm=NONE ctermfg=yellow  ctermbg=NONE

	au BufEnter * if &textwidth > 0 | exec 'match Error99 /\%>' . &textwidth . 'v.\+/' | endif
	"au BufEnter * exec 'syn match ErrorSpace /^\t* \+\|[ \t]\+$/'
	au BufEnter * exec 'syn match ErrorSpace /[ \t]\+$/'
	do BufEnter
endif


"""
""" GIT
"""
ab obrev Reviewed-by: Rodrigo Belem <rodrigo.belem@openbossa.org>
ab indtrev Reviewed-by: Rodrigo Belem <ext-rodrigo.belem@nokia.com>

ab obsig Signed-off-by: Rodrigo Belem <rodrigo.belem@openbossa.org>
ab indtsig Signed-off-by: Rodrigo Belem <ext-rodrigo.belem@nokia.com>

"""
""" Omnicpp
"""
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
map <F10> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
if has("autocmd")
	" automatically open and close the popup menu / preview window
	au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
	set completeopt=menuone,menu,longest,preview
endif

"-------------------------------------------------------------------------------
" additional mapping : {<CR> always opens a block
"-------------------------------------------------------------------------------
inoremap  <buffer>  {<CR>  {<CR>}<Esc>O
vnoremap  <buffer>  {<CR> s{<CR>}<Esc>P=iB

" Some tricks for mutt
" F1 through F3 re-wraps paragraphs in useful ways
if has("autocmd")
	augroup MUTT
		au BufRead ~/.mutt/temp/mutt* set spell " <-- vim 7 required
		au BufRead ~/.mutt/temp/mutt* nmap  <F1>  gqap
		au BufRead ~/.mutt/temp/mutt* nmap  <F2>  gqqj
		au BufRead ~/.mutt/temp/mutt* nmap  <F3>  kgqj
		au BufRead ~/.mutt/temp/mutt* map!  <F1>  <ESC>gqapi
		au BufRead ~/.mutt/temp/mutt* map!  <F2>  <ESC>gqqji
		au BufRead ~/.mutt/temp/mutt* map!  <F3>  <ESC>kgqji
	augroup END
endif

" dictionary for word auto completion
set dictionary+=/usr/share/dict/words
