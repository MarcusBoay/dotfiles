" setting all tab spaces to use 4 spaces instead of one \t
" https://stackoverflow.com/a/234578
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" here because vim 7's default is noautoindent
" otherwise, this isn't really needed for neovim lol
set autoindent

" show line numbers
" https://stackoverflow.com/a/10274166
set number

" ignores case and smartcase so that if a pattern contains uppercase, it is case sensitive
" http://vim.wikia.com/wiki/Searching (under 'Case Sensitivity')
set ignorecase
set smartcase

" shows trailing whitespace
" https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/d2ra7qh/
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" shows the command as visual feedback for using the leader key
set showcmd

" sets general buffer keybinds and options
" https://github.com/ap/vim-buftabline#buffer-basics

set hidden
nnoremap <C-N> :bnext<CR>
nnoremap <C-B> :bprev<CR>
set autoread

" allows one line above/below the cursor when scrolling down a file
set scrolloff=1

" uses the system clipboard
set clipboard^=unnamed,unnamedplus

" make fonts darker
set background=light
