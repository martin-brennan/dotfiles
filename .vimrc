set shell=zsh
syntax on
packadd minpac
call minpac#init({ 'verbose': 2 })

nnoremap q: <nop>
nnoremap Q <nop>

let g:git_messenger_close_on_cursor_moved = v:false
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_always_into_popup = v:true
let g:git_messenger_include_diff = "current"
let g:git_messenger_preview_mods = "botright"
let g:ale_disable_lsp = 1

call minpac#add('neoclide/coc.nvim', {'rev': 'release'})
call minpac#add('antoinemadec/coc-fzf')

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Make vim backspace behave sensibly https://til.hashrocket.com/posts/f5531b6da0-backspace-options
set backspace=indent,eol,start

" remap $ to go to the last non-whitespace character in line in visual mode,
" rarely do i want to select the rest of the line with the blank \n at the
" end, usually this is used for replacing the rest of the line
vnoremap $ g_

" slow typescript highlighting fixes
" call minpac#add('leafgarland/typescript-vim')
" call minpac#add('peitalin/vim-jsx-typescript')
" call minpac#add('othree/yajs.vim')
" au BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.typescriptreact

" HCL formatting, not often used
" call minpac#add('fatih/vim-hclfmt')

" file operations (Delete, Rename etc.)
call minpac#add('tpope/vim-eunuch')

" allows incrementing numbers in a visual mode column
call minpac#add('triglav/vim-visual-increment')

" use fzf for ctrl+p project-wide file search, tags in files, etc.
call minpac#add('junegunn/fzf', { 'do': { -> fzf#install() } })
call minpac#add('junegunn/fzf.vim')
let g:fzf_layout = { 'down': '40%' }

" used by git blame functionality
call minpac#add('rhysd/git-messenger.vim')

" rails tooling
call minpac#add('tpope/vim-rails')

" git tooling
call minpac#add('tpope/vim-fugitive')

" allows fugitive to browse with github
call minpac#add('tpope/vim-rhubarb')

" run rspec from vim
call minpac#add('vim-test/vim-test')

" auto pairing of symbols
call minpac#add('jiangmiao/auto-pairs')

" emmet HTML expansion
call minpac#add('mattn/emmet-vim')

" word motions for moving through camel case and underscores
call minpac#add('vim-scripts/camelcasemotion')

" allows easy block commenting
call minpac#add('tpope/vim-commentary')

" allows surrounding with quotes and toggling quotes
call minpac#add('tpope/vim-surround')

" allows repeating surrounds
call minpac#add('tpope/vim-repeat')

" fancy status bar
call minpac#add('vim-airline/vim-airline')

" js formatting and snippets
call minpac#add('pangloss/vim-javascript')

" color theme
call minpac#add('morhetz/gruvbox')

" snippets
call minpac#add('SirVer/ultisnips')

" allows calling Autoformat which hooks into e.g. rubocop
call minpac#add('Chiel92/vim-autoformat')

" needed for vim-ruby-block-helpers
call minpac#add('kana/vim-textobj-user')

" shows diffs in gutter
call minpac#add('mhinz/vim-signify')

" navigation for ruby blocks e.g. start/end/parent, works with V
call minpac#add('dewyze/vim-ruby-block-helpers')

" ember syntax
call minpac#add('joukevandermaas/vim-ember-hbs')

" run :Prettier to format JS
call minpac#add('prettier/vim-prettier')

" generates tags for jumping to definitions in source
call minpac#add('vim-scripts/taglist.vim')

" shows yaml structure in status bar
call minpac#add('Einenlum/yaml-revealer')

" ale for linting, eslint etc.
call minpac#add('dense-analysis/ale')

" find and replace multiple variants of a word (Subvert)
" e.g. Address/address/addresses replace with Location/location/locations
call minpac#add('tpope/vim-abolish')

" puppet file syntax
call minpac#add('rodjek/vim-puppet')

" saves vim session state and can be restored by tmux-ressurect
call minpac#add('tpope/vim-obsession')

" rubocop issues in the editor
call minpac#add('ngmy/vim-rubocop')

" splits between single/multiple lines, little flaky
call minpac#add('AndrewRadev/splitjoin.vim')

" python autocomplete
call minpac#add('davidhalter/jedi-vim')

" golang tooling for vim
call minpac#add('fatih/vim-go')
let g:go_imports_autosave = 0
let g:go_fmt_autosave = 0
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1

set timeoutlen=1000 ttimeoutlen=0

" js auto import variable
call minpac#add('kristijanhusak/vim-js-file-import')

" replace word under cursor
call minpac#add('chiedo/vim-dr-replace')

packloadall

command! PackInstall call minpac#update()
command! PackUpdate call minpac#update()
command! PackClean call minpac#clean()
command! PackStatus call minpac#status()

" colour and terminal stuff
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:gruvbox_transparent_bg=1
colorscheme gruvbox
let base16colorspace=256
set background=dark
set t_Co=256
set scrolloff=5
set colorcolumn=80
highlight ColorColumn ctermbg=234

" spell check for markdown files and highlighting the mistakes
autocmd FileType markdown setlocal spell
autocmd FileType gitcommit setlocal spell
highlight SpellBad    ctermfg=167      ctermbg=016     cterm=underline      guifg=#FFFFFF   guibg=#000000   gui=none

autocmd FileType html.handlebars setlocal noeol binary

" ignore swap file already exists error
set noswapfile

" airline status bar customization
let g:airline_section_b = ""
let g:airline#extensions#tabline#formatter = 'unique_tail'

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

" *---------------------------------------------------*
" |               CUSTOM KEYBOARD MAPPINGS            |
" ----------------------------------------------------

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" re-select after indenting
vnoremap < <gv
vnoremap > >gv

" replace all under cursor
nnoremap \ :DrAll

" digital garden markdown shortcuts
vnoremap S3" <esc>`<O<esc>S"""<esc>`>o<esc>S"""<esc>k$
vnoremap <leader>bl y :'<,'>s/<c-r>"/\[\[\0\]\]/g<cr>
vnoremap <leader>ml y :'<,'>s/<c-r>"/\[\0\](LINK)/g<cr>/LINK<cr>ciw
vnoremap <leader>cml y :'<,'>s/<c-r>"/\[\0\](LINK)/g<cr>/LINK<cr>viwp
nnoremap <leader>0 vi["my<Left>dt(dt<Space><Left>"mp`[v`]
vnoremap <leader>bq =gv:s/<blockquote>\n//g<cr>gv:s/<\/blockquote//g<cr>gv:s/<\/p>/\r>/g<cr>gv:s/<p>/> /g<cr>gv:s/<ci/> <ci/g<cr>

" I am used to CTRL-p so use it, additionally allow for some extra
" help in normal/visual mode, also add alternate ways of triggering
" it, you can never have too much file access
nmap <C-p> :Files<cr>
nmap <leader>m :Files<cr>
nmap <leader>t :Files<cr>
nmap ff :Files<cr>

" replace quick shortcuts
nmap <C-h> :%s/ 
vnoremap <C-h> s/ 
nmap <leader>h :History<cr>

" ctags for the file listed using fzf
nmap <leader><leader> :BTags<cr>

" list of all currently changed git files listed with fzf
nmap <leader>gg :GFiles?<cr>

" search last ? search used
nmap <leader><Tab> ?<Up><cr>

" navigate quickfix list
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>

" delete all binding.pry instances and debugger instances
nmap <leader>ddd :g/binding.pry/d<cr> :g/debugger/d<cr>

" remap down key in autocomplete
inoremap <C-o> <C-n>
inoremap <expr> <C-p>     pumvisible() ? "\<C-n>" : "\<Down>"

" make enter work coc-nvim
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" file name and path copying
nmap <leader>fn :let @+=expand("%")<CR>
nmap <leader>fp :let @+=expand("%:p")<CR>

" quick select all
nnoremap <leader>sa ggVG

" paste inside
nnoremap <leader>pi" vi"p

" quick reindent
nnoremap <leader>== ggVG=

" quick split and switch to new split window
nnoremap <leader>vs :vsplit<cr><ESC>:wincmd l<cr>
nnoremap <leader>hs :split<cr><ESC>:wincmd j<cr>
nnoremap <leader>w :wincmd w<cr>

" ruby hash block manipulation (not needed with syntax_tree)
nnoremap <leader>hh ci{<cr><ESC>pi<cr><ESC>v2k=
nnoremap <leader>hd ci{<cr><ESC>pi<cr><ESC>v2k=/{<cr>vl:s/{/do/g<cr>/}<cr>vl:s/}/end/g<cr>
vnoremap <leader>hj :s/, /,\r/g<cr>`[V`]=

" ruby format block (not needed with syntax_tree)
nmap <leader>Fb ]sv]e=<cr>

" quick select ruby block/method
nmap <leader>vb ^]sv]e
nmap <leader>vib ^]sjv]ek
nmap <leader>Rs ^]s
nmap <leader>Re ^]e
nmap <leader>Rp ^]p
nmap rs ^]s
nmap re ^]e
nmap rp ^]p
vmap rs ^]s
vmap re ^]e
vmap rp ^]p
nmap rn ]m
nmap rm [m

" navigate between git changes
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" i have ctrl+v mapped to paste so this
" lets me use visual block mode
nnoremap <c-v> <c-s-v>

" vnoremap J :s/\s*$//<cr>gvJgv:s/ \./\./g<cr>
" vmap <leader>J gJ<cr>kV:s/\s*$//<cr>

" i use ? for global project search so remap "
" to reverse-search
" nnoremap ` ?
nnoremap ~ ?
nnoremap " ?

" list all buffers with fzf for easier switching
nmap <leader>b :Buffers<cr>

" search entire project using ripgrep
nmap <leader>f :Rg 
nmap ? :Rg 

" ripgrep configuration
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

" search entire project for word under cursor using ripgrep
nnoremap <silent> & :Rg <C-R><C-W><CR>

" running specs for ruby bindings
nmap <leader>s :! clear && smarttest.sh %:p<cr>
nmap <leader>x :! clear && smarttest.sh %:p noheadless<cr>
nmap <leader>k :! clear && smarttest.sh %:p last<cr>
nmap <leader>l :execute ":! clear && smarttest.sh " . "%:p" . "\\:" . line(".")<cr>

" easy vimrc editing, first is reload, second is opening config
nmap <leader>vr :so $MYVIMRC<cr>
nmap <leader>vc :e $MYVIMRC<cr>

" vim-surround helpers/quick actions for words
nmap '" viwS"
nmap '' viwS'

autocmd BufNewFile,BufRead *.hcl set filetype=hcl
autocmd BufNewFile,BufRead *.hcl.erb set filetype=hcl
autocmd BufNewFile,BufRead *.hcl set syntax=hcl
autocmd BufNewFile,BufRead *.hcl.erb set syntax=hcl
autocmd BufNewFile,BufRead *.nomad set filetype=hcl
autocmd BufNewFile,BufRead *.nomad.erb set filetype=hcl
autocmd BufNewFile,BufRead *.nomad set syntax=hcl
autocmd BufNewFile,BufRead *.nomad.erb set syntax=hcl

" F9 to format file with the appropeiate tool based on filetype
noremap <F9> :Autoformat<CR>
noremap rr :Autoformat<CR>
augroup formatting
  autocmd!
  autocmd FileType javascript noremap <buffer> <F9> :ALEFix<CR>
  autocmd FileType scss noremap <buffer> <F9> :ALEFix<CR>
  autocmd FileType ruby noremap <buffer> <F9> :ALEFix<CR>
  autocmd FileType hcl noremap <buffer> <F9> :HclFmt<CR>
  autocmd FileType go noremap <buffer> <F9> :GoFmt<CR>:GoImports<CR>
  autocmd FileType html.handlebars noremap <buffer> <F9> :ALEFix<CR>
  autocmd FileType javascript noremap <buffer> rr :ALEFix<CR>
  autocmd FileType scss noremap <buffer> rr :ALEFix<CR>
  autocmd FileType ruby noremap <buffer> rr :ALEFix<CR>
  autocmd FileType hcl noremap <buffer> rr :HclFmt<CR>
  autocmd FileType go noremap <buffer> rr :GoFmt<CR>:GoImports<CR>
  autocmd FileType html.handlebars noremap <buffer> rr :ALEFix<CR>
augroup END

" go always uses 4 spaces for indentation
augroup tabs
  autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" only enable emmet for file types that make sense
let g:user_emmet_install_global = 0
autocmd FileType html,css,erb,hbs EmmetInstall

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

" case based on either lowercase or uppercase for search to avoid \c
set ignorecase
set smartcase

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
set cursorline

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" make sure switching buffers doesn't make us lose undo history!!!
set hidden
filetype plugin indent on

" ALE config, only relevant one is the fixers really
" let g:ale_open_list = 'on_save'
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
" let g:ale_linters = {'javascript': ['eslint']}
" let g:ale_linters_explicit = 1
" let g:ale_sign_error = '!!'
" let g:ale_sign_warning = '~~'
let g:ale_virtualtext_cursor = 0
autocmd FileType html.handlebars let b:ale_javascript_prettier_options = '--parser=glimmer'
let g:ale_fixers = {'javascript': ['prettier'], 'css': ['prettier'], 'scss': ['prettier'], 'ruby': ['syntax_tree'], 'handlebars': ['prettier']}

" makes it so when copying using
" yy etc we copy to the system
" clipboard as well, this means we
" can copy between different vims
" as well. needs vim-gtk on KDE
" set clipboard=unnamedplus
" set in local.vim, OSX uses unnamed, linux uses unnamedplus

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
  if a:optionalSha == 'main' || a:optionalSha == 'mainfile'
    let repoSha = 'main'
  else
    let repoSha = substitute(repoShaN, '\r\?\n\+$', '', '')
  endif

  let link = 'https://github.com/'. repo . '/blob/' . repoSha . relative
  if a:optionalSha != 'file' && a:optionalSha != 'mainfile'
    let link = link . '#L'. a:line1 . '-L' . a:line2
  endif

  let @+ = link
  let @* = link

  echo link
endfunction

func! GetSelectedText()
  normal gv"xy
  let result = getreg("x")
  return result
endfunc

" open the current file in github's blame UI
function! s:GithubBlame()
  let path = resolve(expand('%:p'))
  let dir = shellescape(fnamemodify(path, ':h'))
  let originRepo = system('cd ' . dir . ' && git config --get remote.origin.url')
  let repoN = substitute(split(originRepo, ':')[1], '.git', '', '')

  let repo = substitute(repoN, '\r\?\n\+$', '', '')
  let root = system('cd ' . dir . '  && git rev-parse --show-toplevel')
  let relative = strpart(path, strlen(root) - 1, strlen(path) - strlen(root) + 1)

  let link = 'https://github.com/'. repo . '/blame/main' . relative

  let @+ = link
  let @* = link

  echo link
endfunction

" open the current file in github's history UI
function! s:GithubHistory()
  let path = resolve(expand('%:p'))
  let dir = shellescape(fnamemodify(path, ':h'))
  let originRepo = system('cd ' . dir . ' && git config --get remote.origin.url')
  let repoN = substitute(split(originRepo, ':')[1], '.git', '', '')

  let repo = substitute(repoN, '\r\?\n\+$', '', '')
  let root = system('cd ' . dir . '  && git rev-parse --show-toplevel')
  let relative = strpart(path, strlen(root) - 1, strlen(path) - strlen(root) + 1)

  let link = 'https://github.com/'. repo . '/commits/main' . relative

  let @+ = link
  let @* = link

  echo link
endfunction

" get the github link with line numbers for the current selection in visual mode
function! s:CommitLink()
  let sha = GetSelectedText()
  let path = resolve(expand('%:p'))
  let dir = shellescape(fnamemodify(path, ':h'))
  let originRepo = system('cd ' . dir . ' && git config --get remote.origin.url')
  let repoN = substitute(split(originRepo, ':')[1], '.git', '', '')
  let repo = substitute(repoN, '\r\?\n\+$', '', '')
  let link = 'https://github.com/' . repo . '/commit/' . sha
  let @+ = link
  let @* = link

  echo link
endfunction

command! -bar -bang -range -nargs=* GithubLink
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'auto')
command! -bar -bang -range -nargs=* GithubLinkMain
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'main')
command! -bar -bang -range -nargs=* GithubLinkFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'file')
command! -bar -bang -range -nargs=* GithubLinkMainFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'mainfile')
command! -bar -bang -range -nargs=* CommitLink
  \ keepjumps call <sid>CommitLink()

command! -bar -bang -range -nargs=* GithubBlame
  \ keepjumps call <sid>GithubBlame()
command! -bar -bang -range -nargs=* GithubHistory
  \ keepjumps call <sid>GithubHistory()

" cryptic, gets the github commit link for a commit opened with git-messenger
nmap <leader>gcl eewwwwwviw::CommitLink<cr>
vmap <leader>cl :CommitLink<cr>
nmap <leader>gm :GitMessenger<cr>
vmap <leader>gh :GithubLink<cr>
nmap <leader>gl :! clear && bgb %:p<cr>
nmap <leader>ghf :GithubLinkMasterFile<cr>

function! s:notify_file_change_discourse()
  let notify = getcwd() . "/bin/notify_file_change"
  if ! executable(notify)
    let root = rails#app().path()
    notify = root . "/bin/notify_file_change"
  end
  if executable(notify)
    if executable('socat')
      execute "!" . notify . ' ' . expand("%:p") . " " . line(".")
    end
  end
endfunction

autocmd BufWritePost * silent! call s:notify_file_change()

source ~/.config/vim/local.vim
