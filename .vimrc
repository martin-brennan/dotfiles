
packadd minpac
call minpac#init()

call minpac#add('kien/ctrlp.vim')

" use fzf for ctrl+p
call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' })
call minpac#add('junegunn/fzf.vim')
call minpac#add('vim-airline/vim-airline')
call minpac#add('pangloss/vim-javascript')
call minpac#add('morhetz/gruvbox')
call minpac#add('SirVer/ultisnips')
call minpac#add('honza/vim-snippets')
call minpac#add('Chiel92/vim-autoformat')
call minpac#add('kana/vim-textobj-user')
call minpac#add('mhinz/vim-signify')
call minpac#add('dewyze/vim-ruby-block-helpers')
call minpac#add('joukevandermaas/vim-ember-hbs')
call minpac#add('prettier/vim-prettier')
call minpac#add('vim-scripts/taglist.vim')

call minpac#add('dracula/vim', {'name': 'dracula'})
packadd! dracula
" colorscheme dracula
colorscheme gruvbox
set background=dark

packloadall

command! PackInstall call minpac#update()
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" set spacebar to leader
let mapleader = "\<Space>"

" enable matching blocks using visual mode
runtime macros/matchit.vim

" I am used to CTRL-p so use it, additionally allow for some extra
" help in normal/visual mode
nmap <leader>h <plug>(fzf-maps-n)
xmap <leader>h <plug>(fzf-maps-x)
nmap <C-p> :Files<cr>
nmap <leader>a :BTags<cr>
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|adminjs\|tmp\|jsapp'

" otherwise not all files show up...this should be the default
let g:ctrlp_max_files = 0

" custom keyboard mappings
" navigate between git changes
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" i have ctrl+v mapped to paste so this
" lets me use visual block mode
nnoremap <c-v> <c-s-v>

nmap <leader>b :Buffers<cr>
nmap <leader>f :Ag 
nmap ? :Ag 

" ghetto rspec commands without vim-rails
nmap <leader>s :! bundle exec rspec %<cr>
nmap <leader>l :execute ":! bundle exec rspec %:" . line(".")<cr>

" easy vimrc editing
nmap <leader>vr :so $MYVIMRC<cr>
nmap <leader>vc :e $MYVIMRC<cr>

" F3 to format file
noremap <F3> :Autoformat<CR>
augroup formatting
  autocmd!
  autocmd FileType javascript noremap <buffer> <F3> :Prettier<CR>
augroup END

" convinient save shortcut
map SS :w<CR>

" switch between buffers
nmap <leader>[ :bprevious<CR>
nmap <leader>] :bnext<CR>

" quicker update time, used by gitgutter mainly
set updatetime=100

" set tabs/spaces and line numbering
set expandtab
set number
set relativenumber
set ttyfast
set re=1
set tabstop=2
set softtabstop=2
set shiftwidth=2
filetype plugin indent on

" fix cursor disappearing on lines which have warnings e.g.
" rubocop or lint errors
let g:ale_echo_cursor = 0

" makes it so when copying using
" yy etc we copy to the system
" clipboard as well, this means we
" can copy between different vims
" as well. needs vim-gtk on KDE
set clipboard=unnamedplus
set showcmd

" history is ridiculously low out of the box set at 20
set history=1000

" fix syntax highlighting breaking
" https://github.com/vim/vim/issues/2790
set redrawtime=10000

" move swap files out of the way
" this gets really annoying having to add this to .gitignore
" or checking them in by mistake when forcing an add
set directory=$HOME/.vim/swapfiles/
set backupdir=$HOME/.vim/backupdir/
