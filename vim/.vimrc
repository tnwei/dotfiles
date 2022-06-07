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

" For toggle comments, found at https://stackoverflow.com/a/40167715/13095028
Plug 'tpope/vim-commentary'

" Shows an indent line
Plug 'Yggdroot/indentLine'

" Initialize plugin system
call plug#end()

" Markdown workaround from
" https://stsievert.com/blog/2016/01/06/vim-jekyll-mathjax/ 
function! MathAndLiquid()
    "" Define certain regions
    " Block math. Look for "$$[anything]$$"
    syn region math start=/\$\$/ end=/\$\$/
    " Block math in Hugo
    syn region mathtwo start=/\\\\(/ end=/\\\\)/
    " inline math. Look for "$[not $][anything]$"
    syn match math_block '\$[^$].\{-}\$'

    " Liquid single line. Look for "{%[anything]%}"
    syn match liquid '{%.*%}'
    " Liquid multiline. Look for "{%[anything]%}[anything]{%[anything]%}"
    syn region highlight_block start='{% highlight .*%}' end='{%.*%}'
    " Fenced code blocks, used in GitHub Flavored Markdown (GFM)
    syn region highlight_block start='```' end='```'

    "" Actually highlight those regions.
    hi link math Statement
    hi link mathtwo Statement
    hi link liquid Statement
    hi link highlight_block Function
    hi link math_block Function
endfunction

" Call everytime we open a Markdown file
autocmd BufRead,BufNewFile,BufEnter *.md,*.markdown call MathAndLiquid()


" Activate colorscheme
" Don't think this works well over PuTTY?
" colorscheme serenade

" Limelight config

" Limelight shadow color config required if color scheme unsupported
" :help cterm-colors
let g:limelight_conceal_ctermfg = 'darkgray'
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

" Use Goyo by typing `:Goyo` to toggle on/off
autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" For toggling comments using Ctrl + /
" Toggles the line that the cursor is on, in normal mode 
" Also works for highlighted lines in Visual mode
" ref: https://stackoverflow.com/a/9051932/13095028
noremap <C-_> :Commentary<cr>

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

" Search results show as I type them
set incsearch

" These two combined basically use only hard tabs
" Set tabs
" Width of a hard tabstop measured in 'spaces'
" Basically defines how to read a \t
set tabstop=4

" Set indent == single tab
" Size of an indent
set shiftwidth=4

" For better yaml editing
" ref: https://www.arthurkoziel.com/setting-up-vim-for-yaml/
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


" Map F9 to run .py files
" This will drop to shell to run
" After code is executed, press ENTER to return to vim
" Thanks to https://stackoverflow.com/questions/18948491/running-python-code-in-vim
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

" Show matching braces
set showmatch

" Enable Python syntax highlighting
let python_highlight_all = 1

" Disable quote concealing in JSON files
" indentLine needs conceallevel to work
" thankfully there is a JSON-specific disable
let g:vim_json_conceal=0
