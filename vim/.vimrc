" Plugins, using vim-plug
" Remember to run :PlugInstall to install declared plugins!
" https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" Highlights paragraphs around the cursor
" Needs tweaking the colours but otherwise quite neat
Plug 'https://github.com/junegunn/limelight.vim'

" Serenade colour scheme, gentle and easy on the eye
Plug 'b4skyx/serenade'

" :Goyo for a centered, distraction-free layout
Plug 'junegunn/goyo.vim'

" Initialize plugin system
call plug#end()

" Activate colorscheme
" Don't think this works well over PuTTY?
colorscheme serenade

" Limelight config

" Limelight shadow color config required if colro scheme unsupported
" :help cterm-colors
" let g:limelight_conceal_ctermfg = 'darkgray'
" I'd rather keep all cterms
" let g:limelight_conceal_guifg = '#5A6374'

" This doesn't work if unsupported color scheme
" let g:limelight_default_coefficient = 0.9

let g:limelight_paragraph_span = 1

" Goyo config
" Quit on :q
" https://github.com/junegunn/goyo.vim/wiki/Customization#ensure-q-to-quit-even-when-goyo-is-active

function! s:goyo_enter()
  " Quit on :q
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  " Limelight on
  Limelight

endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

  " Limelight off
  Limelight!

endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Set such that the cursor has +/- N lines on screen
" Use a really large number like 999 for the cursor to be centered vertically
set scrolloff=2

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
