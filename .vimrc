" Allows pathogen to be run as a bundle

runtime bundle/vim-pathogen/autoload/pathogen.vim

" Start pathogen

execute pathogen#infect()

" Disable filetype detection

filetype off

" Enables language-specific indenting rules

filetype plugin indent on

" Turns on syntax highlighting

syntax on

" Leave hidden buffers open

set hidden

" Always display the status line

set laststatus=2

" Hide the ugly default mode text in the statusline

set noshowmode

" Set airline theme

let g:airline_theme='irblack'

" Enable powerline fonts so powerline symbols look pretty on the statusline

let g:airline_powerline_fonts = 1

" Save 100 commands in the buffer (8 by default)

set history=100

" Shows line numbers

set number

" Try to use 256-color terminal

set t_Co=256

" Set the colorscheme

colorscheme ir_black

" Set initial window size

set columns=80

" Wrap as close to n characters as white space allows without exceeding the
" limit

set formatoptions+=t

" Set textwidth to 80 (to allow wrapping)

set tw=80

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

" Highlight whitespace

set list

" Show whitespaces as a sexy character (10x spf13)

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

" Inverts the previous value of the paste option in normal mode

nnoremap <F2> :set invpaste paste?<CR>

" Don't enter insert mode after new line after/before the current line. Remaps
" Enter to 'o' (after) and Shift + Enter to 'O' (before)

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
