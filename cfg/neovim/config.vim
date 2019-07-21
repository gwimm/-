"	    __ _  _  _  __  _  _  ____   ___
"	   (  ( \/ )( \(  )( \/ )(  _ \ / __)
"	 _ /    /\ \/ / )( /    \ )   /( (__
"	(_)\_)__) \__/ (__)\_)(_/(__\_) \___)
"	dheu

set clipboard+=unnamedplus
set nowrap
set fillchars="fold: "
set undodir=$HOME/.cache/nvim/undo undofile
set noshowmode shortmess=acWF
set nobackup nowritebackup
set hidden emoji

set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType sh setlocal sw=4 sts=4 et
autocmd FileType python setlocal sw=4 sts=4 noet
autocmd FileType javascript setlocal sw=2 sts=2 et
autocmd FileType haskell setlocal sw=2 sts=2 et
autocmd FileType json setlocal sw=2 sts=2 et
autocmd FileType ruby setlocal sw=2 sts=2 noet
autocmd FileType moon setlocal sw=2 sts=2 et
autocmd FileType crystal setlocal sw=2 sts=2 noet
autocmd FileType llvm setlocal sw=2 sts=2 et commentstring=;\ %s
autocmd FileType hoon setlocal sw=2 sts=2 et commentstring=::\ \ %s
autocmd FileType c setlocal sw=4 sts=4 et commentstring=//\ %s
autocmd FileType cpp setlocal sw=4 sts=4 et commentstring=//\ %s
autocmd FileType asm setlocal sw=4 sts=4 et commentstring=;\ %s
autocmd FileType nasm setlocal sw=4 sts=4 et commentstring=;\ %s
let g:asmsyntax = 'nasm'

highlight Statusline      cterm=NONE
highlight MatchParen      ctermbg=0   ctermfg=14
highlight EndOfBuffer                 ctermfg=0
highlight OverLength      ctermbg=5   ctermfg=0
match OverLength /\%81v./

set statusline=%<%=%-14.(%l\ %c%)

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
Plug 'ntpeters/vim-better-whitespace'
Plug 'sgur/vim-editorconfig'
Plug 'prurigro/vim-polyglot-darkcloud'
Plug 'leafo/moonscript-vim'
Plug 'rhysd/vim-crystal'
Plug 'urbit/hoon.vim'
Plug 'shiracamus/vim-syntax-x86-objdump-d'
Plug 'rhysd/vim-llvm'
call plug#end()

function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! o"
  execute "normal! o"
  execute "normal! o"
  execute "normal! Go#endif // " . gatename
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

let mapleader = '<'
let maplocalleader = ';'

nnoremap <Tab> za
nnoremap Y y$
nnoremap k gk
vnoremap k gk
nnoremap j gj
vnoremap j gj

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <silent>gb :bnext<CR>
nnoremap <silent>gB :bprevious<CR>

let g:python3_host_prog = '/sai/.local/share/pyenv/versions/nvim3/bin/python'
let $NVIM_TUI_ENABLE_TRUE_COLOR=0
let $TERM = "xterm"
set notermguicolors

