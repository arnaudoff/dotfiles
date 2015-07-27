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

" Enable powerline fonts so powerline symbols look pretty on the statusline

let g:airline_powerline_fonts = 1

" Save 100 commands in the buffer (8 by default)

set history=100

" Shows line numbers

set number

" Set terminal colouring to 256. (if applicable) 

set t_Co=256

" Set the colorscheme.

colorscheme xoria256

" Use indents of 4 spaces

set shiftwidth=4

" An indentation every four columns

set tabstop=4

" Make it so backspace deletes indent

set softtabstop=4

" Tabs are spaces, not tabs

set expandtab

" Same ideas, different values - Ruby specific indent

autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2

" Highlight whitespace (10x spf13)

set list

" Show whitespaces as a sexy character

set listchars=tab:›\ ,trail:•,extends:#,nbsp:. 

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
