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

call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
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

let g:coc_fzf_preview = 'right:50%'

" Symbol renaming.
nmap <leader>rr <Plug>(coc-rename)

" remap $ to go to the last non-whitespace character in line in visual mode,
" rarely do i want to select the rest of the line with the blank \n at the
" end, usually this is used for replacing the rest of the line
vnoremap $ g_

" call minpac#add('prabirshrestha/vim-lsp')
" call minpac#add('mattn/vim-lsp-settings')

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

" hashicorp HCL syntax
call minpac#add('jvirtanen/vim-hcl')

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
call minpac#add('honza/vim-snippets')

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
" call minpac#add('dense-analysis/ale')

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

" ignore swap file already exists error
set noswapfile

" airline status bar customization
let g:airline_section_b = ""
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" change Autoformat behaviour for rubocop
let g:formatdef_my_custom_rubocop = "'rubocop -A -o /dev/null -s '.bufname('%').' \| sed -n 2,\\$p'"
let g:formatters_ruby = ['my_custom_rubocop']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" set spacebar to leader
let mapleader = "\<Space>"

" enable matching blocks using visual mode
runtime macros/matchit.vim

" replace currently selected text with default register
" without yanking it
vnoremap p "_dP

" re-select after indenting
vnoremap < <gv 
vnoremap > >gv 

" replace all under cursor
nnoremap \ :DrAll 

vnoremap S3" <esc>`<O<esc>S"""<esc>`>o<esc>S"""<esc>k$

" digital garden markdown shortcuts
vnoremap <leader>bl y :'<,'>s/<c-r>"/\[\[\0\]\]/g<cr>
vnoremap <leader>ml y :'<,'>s/<c-r>"/\[\0\](LINK)/g<cr>/LINK<cr>ciw
vnoremap <leader>cml y :'<,'>s/<c-r>"/\[\0\](LINK)/g<cr>/LINK<cr>viwp
nnoremap <leader>0 vi["my<Left>dt(dt<Space><Left>"mp`[v`]
vnoremap <leader>bq =gv:s/<blockquote>\n//g<cr>gv:s/<\/blockquote//g<cr>gv:s/<\/p>/\r>/g<cr>gv:s/<p>/> /g<cr>gv:s/<ci/> <ci/g<cr>

" I am used to CTRL-p so use it, additionally allow for some extra
" help in normal/visual mode
nmap <C-p> :Files<cr>
nmap <leader>h <plug>(fzf-maps-n)
xmap <leader>h <plug>(fzf-maps-x)
nmap <leader>t :Files<cr>
nmap <C-h> :%s/
nmap <leader>h :History<cr>
nmap <leader><leader> :BTags<cr>
nmap <leader>gg :GFiles?<cr>
nmap <leader>Fb ]sv]e=<cr>
nmap <leader><Tab> ?<Up><cr>
nmap <leader>cn :cn<cr>
nmap <leader>cp :cp<cr>

" delete all binding.pry instances and debugger instances
nmap <leader>ddd :g/binding.pry/d<cr> :g/debugger/d<cr>

" remap down key in autocomplete
inoremap <C-o> <C-n>

inoremap <expr> <C-x><C-f> fzf#vim#complete#path("rg --files")
inoremap <expr> <C-p>     pumvisible() ? "\<C-n>" : "\<Down>"

" *---------------------------------------------------*
" |               CUSTOM KEYBOARD MAPPINGS            |
" ----------------------------------------------------

" file name and path copying
nmap <leader>fn :let @+=expand("%")<CR>
nmap <leader>fp :let @+=expand("%:p")<CR>

" add frozen string
nmap <leader>zs ggI# frozen_string_literal: true<CR><CR><ESC>

" quick select all
nnoremap <leader>sa ggVG

" paste inside
nnoremap <leader>pi" vi"p

" quick reinden
nnoremap <leader>== ggVG=

" quick split and switch to new split window
nnoremap <leader>vs :vsplit<cr><ESC>:wincmd l<cr>
nnoremap <leader>hs :split<cr><ESC>:wincmd j<cr>
nnoremap <leader>w :wincmd w<cr>

" ruby hash block manipulation
nnoremap <leader>hh ci{<cr><ESC>pi<cr><ESC>v2k=
nnoremap <leader>hd ci{<cr><ESC>pi<cr><ESC>v2k=/{<cr>vl:s/{/do/g<cr>/}<cr>vl:s/}/end/g<cr>
vnoremap <leader>hj :s/, /,\r/g<cr>`[V`]=

" quick select ruby block/method
nmap <leader>vb ^]sv]e
nmap <leader>vib ^]sjv]ek
nmap <leader>Rs ^]s
nmap <leader>Re ^]e
nmap <leader>Rp ^]p
vmap rs ^]s
vmap re ^]e
vmap rp ^]p
nmap rn ]m
nmap rm [m
vnoremap <leader>sd :s# \+# #g<cr>==

" leader + d deletes without copying t" C-w lo clipboard
nnoremap <!-- <leader> -->d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

" navigate between git changes
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)

" i have ctrl+v mapped to paste so this
" lets me use visual block mode
nnoremap <c-v> <c-s-v>

vnoremap J :s/\s*$//<cr>gvJgv:s/ \./\./g<cr>
" vmap <leader>J gJ<cr>kV:s/\s*$//<cr>

" i use ? for global project search so remap "
" to reverse-search
" nnoremap ` ?
nnoremap ~ ?
nnoremap " ?

" list all buffers with fzf for easier switching
nmap <leader>b :Buffers<cr>

" search entire project using ag
nmap <leader>f :Rg 
nmap ? :Rg 
nnoremap <silent> & :Rg <C-R><C-W><CR>

" running specs for ruby bindings
nmap <leader>s :! clear && smarttest.sh %:p<cr>
nmap <leader>l :execute ":! clear && smarttest.sh " . "%:p" . "\\:" . line(".")<cr>
nmap <leader>ro :g/describe\|scenario\|context\|it/#<cr>

" easy vimrc editing
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

" F9 to format file
noremap <F9> :Autoformat<CR>
augroup formatting
  autocmd!
  autocmd FileType javascript noremap <buffer> <F9> :Prettier<CR>
  autocmd FileType scss noremap <buffer> <F9> :Prettier<CR>
  autocmd FileType ruby noremap <buffer> <F9> :Autoformat<CR>
  autocmd FileType hcl noremap <buffer> <F9> :HclFmt<CR>
  autocmd FileType go noremap <buffer> <F9> :GoFmt<CR>:GoImports<CR>
augroup END

augroup tabs
  autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END

" prettier auto format on save
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.json,*.css,*.scss,*.less,*.graphql PrettierAsync

" only enable emmet for file types that make sense
let g:user_emmet_install_global = 0
autocmd FileType html,css,erb EmmetInstall

" expand emmet vim abbreviations on tab
" augroup emmet
"   autocmd!
"   autocmd FileType html imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"   autocmd FileType handlebars imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"   autocmd FileType erb imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"   autocmd FileType css imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
"   autocmd FileType irb imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
" augroup END

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
" let g:ale_echo_cursor = 0

" only lint ale on save
" let g:ale_open_list = 'on_save'
" let g:ale_lint_on_text_changed = 0
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_save = 1
" let g:ale_fix_on_save = 1
" let g:ale_linters = {'javascript': ['eslint']}
" let g:ale_fixers = {'javascript': ['prettier'], 'css': ['prettier']}
" let g:ale_linters_explicit = 1
" let g:ale_sign_error = '!!'
" let g:ale_sign_warning = '~~'

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
command! -bar -bang -range -nargs=* GithubLinkMaster
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'main')
command! -bar -bang -range -nargs=* GithubLinkFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'file')
command! -bar -bang -range -nargs=* GithubLinkMasterFile
  \ keepjumps call <sid>GithubLink(<line1>, <line2>, 'mainfile')
command! -bar -bang -range -nargs=* CommitLink
  \ keepjumps call <sid>CommitLink()

command! -bar -bang -range -nargs=* GithubBlame
  \ keepjumps call <sid>GithubBlame()

nmap <leader>gcl eewwwvjw::CommitLink<cr>
vmap <leader>cl :CommitLink<cr>
nmap <leader>gm :GitMessenger<cr>
vmap <leader>gh :GithubLink<cr>
nmap <leader>ghf :GithubLinkMasterFile<cr>
nmap <leader>fip :%s/\(\d\{1,3\}[.]\)\{3\}\(\d\{1,3\}\)/9.9.9.9/g <cr>
inoremap <C-d><C-d> <C-r>=substitute(system('date +"%Y-%M-%dT%H:%M"'), '\n\+', '', '')<CR>
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

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

source ~/.config/vim/arch.vim
source ~/.config/vim/colemak.vim
