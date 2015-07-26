" Allows pathogen to be run as a bundle

runtime bundle/vim-pathogen/autoload/pathogen.vim

" Start pathogen

execute pathogen#infect()

" Disable filetype detection

filetype off

" Enables language-specific indenting rules.

filetype plugin indent on

" Turns on syntax highlighting

syntax on  

" Leave hidden buffers open

set hidden

" Always display the status line

set laststatus=2

" Save 100 commands in the buffer (8 by default)

set history=100 

" Shows line numbers

set number 

" Set terminal colouring to 256. (if applicable) 

set t_Co=256

" Set the colorscheme.

colorscheme xoria256

" Sets gVim's font to Consolas, 13

" set guifont=Consolas:h13:cANSI 

" Enables terminal width (by default: 80).
" For detailed explanation:
" http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns

if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" To remind me.. (10x RadoRado) 

nnoremap <Left> :echoe "Use h instead."<CR>
nnoremap <Right> :echoe "Use l instead."<CR>
nnoremap <Up> :echoe "Use k instead."<CR>
nnoremap <Down> :echoe "Use j instead."<CR>

" Adds a corresponding bracket and moves the cursor between the formed pair.

inoremap {<CR> {<CR>}<C-o>O
