set nu
set expandtab
set tabstop=4
syntax on
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>

set backspace=indent " I don't like not being able to backspace

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes
Plug 'christoomey/vim-tmux-navigator'


" Initialize plugin system
call plug#end()

colors zenburn
