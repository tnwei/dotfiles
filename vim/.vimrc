" Default cursor behaviour is to jump physical lines
" Make it jump displayed lines instead
" http://vim.wikia.com/wiki/Move_cursor_by_display_lines_when_wrapping
" Command mode
noremap <Up> gk
noremap <Down> gj
" Insert mode
inoremap <Up> <C-o>gk
inoremap <Down> <C-o>gj

" Shift tab to un-indent
" https://stackoverflow.com/questions/4766230/map-shift-tab-in-vim-to-inverse-tab-in-vim
" for command mode
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>


" this should allow vim to auto-indent when I code in Python
" https://stackoverflow.com/questions/45108986/introduce-tab-in-new-line-while-creating-a-block-for-python-files-in-vim
filetype plugin indent on

" Show line numbers 
set number

" Use soft tabs
set expandtab

" These two combined basically use only hard tabs
" Set tabs
" Width of a hard tabstop measured in 'spaces'
" Basically defines how to read a \t
set tabstop=4

" Set indent == single tab
" Size of an indent
set shiftwidth=4

" Map F9 to run .py files
" This will drop to shell to run
" After code is executed, press ENTER to return to vim
" Thanks to https://stackoverflow.com/questions/18948491/running-python-code-in-vim
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" Show matching braces
set showmatch

" Enable Python syntax highlighting
let python_highlight_all = 1

" Visual line
" set cursorline
