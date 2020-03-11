
packadd minpac
call minpac#init()

call minpac#add('kien/ctrlp.vim')

" use fzf for ctrl+p
call minpac#add('junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' })
call minpac#add('junegunn/fzf.vim')
call minpac#add('tpope/vim-fugitive')
call minpac#add('mattn/emmet-vim')
call minpac#add('tpope/vim-commentary')
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
call minpac#add('Einenlum/yaml-revealer')

call minpac#add('dracula/vim', {'name': 'dracula'})
packadd! dracula
" colorscheme dracula
colorscheme gruvbox
set background=dark
set t_Co=256

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
nmap <leader>t :BTags<cr>

" otherwise not all files show up...this should be the default
" let g:ctrlp_max_files = 0

" *---------------------------------------------------*
" |               CUSTOM KEYBOARD MAPPINGS            |
" ----------------------------------------------------

" quick split and switch to new split window
nnoremap <leader>vs :vsplit<cr><ESC>:wincmd l<cr>
nnoremap <leader>hs :split<cr><ESC>:wincmd j<cr>

" quick select ruby block/method
nmap <leader>vb ^]sv]e

" leader + d deletes without copying t" C-w lo clipboard
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" navigate between git changes
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" i have ctrl+v mapped to paste so this
" lets me use visual block mode
nnoremap <c-v> <c-s-v>

" list all buffers with fzf for easier switching
nmap <leader>b :Buffers<cr>

" search entire project using ag
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

" *--------------------------------------------*
" |       END CUSTOM KEYBOARD MAPPINGS         |
" *--------------------------------------------*

" quicker update time, used by gitgutter mainly
set updatetime=100

" set tabs/spaces and line numbering
set expandtab
set number
set relativenumber
set ttyfast
set re=1
set nocompatible
set tabstop=2
set softtabstop=2
set shiftwidth=2

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" make sure switching buffers doesn't make us lose undo history!!!
set hidden
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

" stolen from sam saffron...modified to always use origin remote
"
" map <leader>g in visual mode to provide a stable link to GitHub source
" allows us to easily select some text in vim and talk about it
  " let repoN = system("cd  . dir .  && git remote -v | awk '{ tmp = match($2, /github/); if (tmp) { split($2,a,/github.com[:\.]/); c = a[2]; split(c,b,/[.]/); print b[1]; exit; }}'")
function! s:GithubLink(line1, line2, optionalSha)
  let path = resolve(expand('%:p'))
  let dir = shellescape(fnamemodify(path, ':h'))
  let originRepo = system('cd ' . dir . ' && git config --get remote.origin.url')
  let repoN = substitute(split(originRepo, ':')[1], '.git', '', '')

  let repo = substitute(repoN, '\r\?\n\+$', '', '')
  let root = system('cd ' . dir . '  && git rev-parse --show-toplevel')
  let relative = strpart(path, strlen(root) - 1, strlen(path) - strlen(root) + 1)

  let repoShaN = system('cd ' . dir . ' && git rev-parse HEAD')
  if a:optionalSha == 'master' || a:optionalSha == 'masterfile'
    let repoSha = 'master'
  else
    let repoSha = substitute(repoShaN, '\r\?\n\+$', '', '')
  endif

  let link = 'https://github.com/'. repo . '/blob/' . repoSha . relative
  if a:optionalSha != 'file' && a:optionalSha != 'masterfile'
    let link = link . '#L'. a:line1 . '-L' . a:line2
  endif

  let @+ = link
  let @* = link

  echo link
endfunction

command! -bar -bang -range -nargs=* GithubLink
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'auto')
command! -bar -bang -range -nargs=* GithubLinkMaster
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'master')
command! -bar -bang -range -nargs=* GithubLinkFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'file')
command! -bar -bang -range -nargs=* GithubLinkMasterFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'masterfile')

vmap <leader>gh :GithubLink<cr>
nmap <leader>ghf :GithubLinkMasterFile<cr>
