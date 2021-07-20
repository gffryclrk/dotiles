colors zenburn

set nu
set expandtab
set tabstop=4
set shiftwidth=4

syntax on
filetype plugin indent on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType jav setlocal ts=4 sts=4 sw=4 expandtab

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-H> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

set backspace=indent " I don't like not being able to backspace

call plug#begin('~/.vim/plugged')
        " Make sure you use single quotes
        Plug 'christoomey/vim-tmux-navigator'
        Plug 'preservim/nerdtree'
        Plug 'tpope/vim-abolish'
        Plug 'hashivim/vim-terraform'
        " Initialize plugin system
call plug#end()

