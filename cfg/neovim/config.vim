"	    __ _  _  _  __  _  _  ____   ___
"	   (  ( \/ )( \(  )( \/ )(  _ \ / __)
"	 _ /    /\ \/ / )( /    \ )   /( (__
"	(_)\_)__) \__/ (__)\_)(_/(__\_) \___)
"	dheu

set clipboard+=unnamedplus
set pastetoggle=<F3>
set ignorecase
set tabstop=4 shiftwidth=4 noexpandtab
set nowrap
set fillchars=fold:\ 
" set list lcs=tab:\▏\ 
set encoding=UTF-8
scriptencoding UTF-8
set undodir=$HOME/.cache/nvim/undo undofile
set noshowmode shortmess=acWF
set nobackup nowritebackup
set splitbelow splitright equalalways
set hidden emoji
set nonumber norelativenumber
set scl=yes
set completeopt=noinsert,menuone
set foldlevel=50 foldcolumn=0


highlight VertSpli        ctermbg=0   ctermfg=14  cterm=NONE
highlight LineNr          ctermbg=0   ctermfg=1   cterm=NONE
highlight FoldColumn      ctermbg=0               cterm=NONE
highlight CursorLine      ctermbg=1               cterm=NONE
highlight Statusline                              cterm=NONE
highlight DiffDelete      ctermbg=0   ctermfg=5
highlight OverLength      ctermbg=5   ctermfg=0
highlight SpellBad        ctermbg=4   ctermfg=14
highlight MatchParen      ctermbg=0   ctermfg=14
highlight Conceal         ctermbg=0   ctermfg=1
highlight SpellBad        ctermbg=0   ctermfg=7
highlight DiffText        ctermbg=11  ctermfg=7
highlight NvimInvalid     ctermbg=7   ctermfg=0
highlight NonText                     ctermfg=11
highlight EndOfBuffer                 ctermfg=0
highlight SpellCap        ctermfg=0
highlight clear SignColumn
highlight SignColumn      ctermbg=0
highlight Visual          ctermbg=4
highlight Colorcolumn     ctermbg=0
highlight Cursorline      ctermbg=0
highlight Folded          ctermbg=0
highlight DiffAdd         ctermbg=0
highlight DiffChange      ctermbg=0
highlight Statement       ctermfg=1
match OverLength /\%81v./

if empty(glob('$XDG_DATA_HOME/nvim/plug.vim'))
	silent !curl -fLo $XDG_DATA_HOME/nvim/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	source $XDG_DATA_HOME/nvim/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $XDG_DATA_HOME/nvim/plug.vim
endif
source $XDG_DATA_HOME/nvim/plug.vim
set runtimepath+=$XDG_DATA_HOME/nvim/plug.vim

call plug#begin('$XDG_DATA_HOME/nvim/plugged')
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
Plug 'markonm/traces.vim'
Plug 'matze/vim-move'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'chrisbra/Colorizer'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

" Plug 'Yggdroot/indentLine'
Plug 'baskerville/vim-sxhkdrc'
Plug 'adimit/prolog.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'cespare/vim-toml'
Plug 'mboughaba/i3config.vim'
Plug 'LnL7/vim-nix'
Plug 'gentoo/gentoo-syntax'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'autozimu/LanguageClient-neovim', {
	\ 'branch': 'next',
	\ 'do': 'bash install.sh',
	\ }

Plug 'lotabout/skim', {
			\ 'dir': '~/bin/src/skim',
			\ 'do': './install'
			\ }

Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-path'
" Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-markdown-subscope'
Plug 'ncm2/ncm2-racer'
Plug 'racer-rust/vim-racer'
call plug#end()

let g:pandoc#folding#fdc = 0
let g:pandoc#folding#mode = "relative"
let g:racer_experimental_completer = 1
let g:gitgutter_enabled = 0

let g:LanguageClient_serverCommands = {
      		\ 'go': ['bingo', '--mode', 'stdio', '--logfile', '/tmp/lspserver.log','--trace', '--pprof', ':6060'],
			\ 'python': ['pyls'],
      		\ 'rust': ['rustup', 'run', 'nightly', 'rls'],
      		\ 'cuda': ['ccls'],
      		\ 'objc': ['ccls'],
			\ 'cpp': ['ccls'],
			\ 'c': ['ccls'],
      		\ }

let g:LanguageClient_diagnosticsDisplay = {
			\     1: {
			\         "name": "Error",
			\         "texthl": "SpellBad",
			\         "signText": "> ",
			\         "signTexthl": "SpellBad",
      		\     },
	  		\     2: {
      		\         "name": "Warning",
      		\         "texthl": "WarningMsg",
      		\         "signText": "! ",
      		\         "signTexthl": "WarningMsg",
      		\     },
      		\     3: {
      		\         "name": "Information",
      		\         "texthl": "WarningMsg",
      		\         "signText": "! ",
      		\         "signTexthl": "WarningMsg",
      		\     },
      		\     4: {
      		\         "name": "Hint",
      		\         "texthl": "WarningMsg",
      		\         "signText": "? ",
      		\         "signTexthl": "WarningMsg",
      		\     },
      		\ }

let g:pandoc#syntax#codeblocks#embeds#langs = ["rust", "c", "cpp", "lisp",
			\ "racket", "go", "prolog", "python", "cotton"]

let mapleader ='<'
let maplocalleader = ';'

nnoremap <silent> gd :vsplit<CR>:call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

autocmd FileType rust nmap gd <Plug>(rust-def-vertical)
autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)

augroup Plug
	autocmd!
	autocmd BufEnter * call ncm2#enable_for_buffer()
augroup END

function! s:insert_include_guards()
	let guardname = substitute(toupper(expand("%:t")), "\\.", "_", "g")
	execute "normal! i#ifndef " . guardname
	execute "normal! o#define " . guardname
	execute "normal! o"
	execute "normal! o"
	execute "normal! o"
	execute "normal! Go#endif /* " . guardname . " */"
	normal! kk
endfunction

function! Multiply()
	if v:count!=0
		let @r=v:count*expand('<cword>') | :norm diw"rP
	endif
endfunction

augroup C
	autocmd!
	autocmd BufNewFile *.{h,hpp,hxx} call <SID>insert_include_guards()
augroup END

set statusline=%<%=%-14.(%l\ %c%)

nnoremap <Tab> za
nnoremap Y y$
nnoremap k gk
vnoremap k gk
nnoremap j gj
vnoremap j gj

nnoremap <silent>gb :bnext<CR>
nnoremap <silent>gB :bprevious<CR>
" nnoremap <silent> gm	:TagbarToggle<CR>:wincmd l<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vnoremap <silent><leader>ma yo<Esc>p^y$V:!perl -e '$x = <C-R>"; print $x'<CR>-y0j0P
nnoremap <silent><C-m> :<C-u>call Multiply()<cr>

let g:python3_host_prog = '/sai/.local/share/pyenv/versions/nvim3/bin/python'
