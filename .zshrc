# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/mb/scripts:/home/mb/repos/ops/bin:$HOME/.local/bin:/usr/local/go/bin:/home/mb/go/bin:$PATH

# dolphin file manager stuff
[ "$XDG_CURRENT_DESKTOP" = "KDE"  ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME"  ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export _JAVA_AWT_WM_NONREPARENTING=1
export HYDRA_URL=http://127.0.0.1:4444
export HYDRA_ADMIN_URL=http://127.0.0.1:4445
export GOPATH=$HOME/go
export PGROOT="/var/lib/postgres"
export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git' -g '!documentation/chat'"
export REPO_BASE_DIRECTORY="$HOME/repos"
export DISCOURSE_REPO_BASE_DIRECTORY="$REPO_BASE_DIRECTORY/discourse"
export DOCKER_GATEWAY_HOST=172.17.0.1
export HUB_BASE_URL="http://localhost:4001/api"
export FZF_DOCKER_PS_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
export FZF_DOCKER_PS_START_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
export VIM_AUTOSPEC=1
export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$HOME/.ripgrep"
export DISCOURSE_ALLOW_UNSECURE_CHAT_UPLOADS=1
export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_SDK_ROOT/emulator
export PATH=$PATH:$ANDROID_SDK_ROOT/platform-tools

# Enter instead of ^M
stty icrnl

# zsh config
ZSH_THEME="robbyrussell"
plugins=(git fzf-docker)
source $ZSH/oh-my-zsh.sh
source $HOME/scripts/fzf-kill.plugin.zsh

alias rgno="rg --no-ignore $@"
alias kk="kill -9 **"
alias gosrc="cd $GOPATH/src"
alias gcdd="git checkout ."
alias rr="cd ~/repos"
alias rubyst="RUBYOPT=\"-W0\" bundle exec stree write --print-width=100 --plugins=plugin/trailing_comma $@"
alias chrome="chromium"
alias lspec="bat ~/scripts/last_spec.txt"
alias revfix="git commit -m \"DEV: Review fixes\""
alias specfix="git commit -m \"DEV: Test fix\""
alias lintfix="git commit -m \"DEV: Lint\""
alias amend="git commit --amend"
alias amendno="git commit --amend --no-edit"
alias amendpush="git commit --amend --no-edit && git push -f"
alias bimig="bundle install && RAILS_ENV=test bundle exec rake db:migrate && RAILS_ENV=development bundle exec rake db:migrate"
alias ddmaster="cd $REPO_BASE_DIRECTORY/master/discourse"
alias gpickaxe="git log -p -S $@"
alias rrm="fzf | xargs -I '{}' rm {}"
alias down="cd ~/Downloads"
alias ccat="pygmentize -f terminal256 -P style=monokai -g $@"
alias dwmcfg="forge && cd dwm && vim config.h"
alias dmenucfg="forge && cd dmenu && vim config.h"
alias stcfg="forge && cd st && vim config.h"
alias lsraw="/usr/bin/ls"
alias ls="ls --color=tty -lah"
alias spotify="/usr/bin/spotify --force-device-scale-factor=1.5"
alias chmx="chmod +x $@"
alias tt="tmux"
alias killconsul="kill -9 $(pidof consul)"
alias killnomad="kill -9 $(pidof nomad)"
alias forge="cd ~/forge"
alias ss="cd ~/scripts"
alias irb="pry"
alias dcu="docker-compose up"
alias mkdir="mkdir -p "
alias gfix="git add . && git commit"
alias escaps="setxkbmap -option caps:swapescape"
alias vimrc="vim ~/.vimrc"
alias nvimrc="cd ~/.config/nvim && nvim ."
alias debugspec="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=debug bundle exec rspec $@"
alias debugspecwarn="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=warn bundle exec rspec $@"
alias chmp="git checkout master && git pull"
alias chma="git checkout main && git pull"
alias annotatemodels="bundle exec annotate"
alias plugspec="IMPROVED_SPEC_DEBUGGING=1 LOAD_PLUGINS=1 be rspec $@"
alias mainfile="git checkout origin/main -- $@"
alias remotelist="git remote -v"
alias commit="git commit"
alias gco="git commit"
alias gk="git commit"
alias gcb="git checkout -b $@"
alias gcl="git checkout -"
alias gll="git checkout -"
alias gpl="git pull"
alias gvv="git pull"
alias gg="git status"
alias lefthooklint="npx lefthook run lints"
alias zshreload="source ~/.zshrc"
alias v="vim"
alias vimold="/usr/local/bin/vim"
alias vim="nvim"
alias zshconfig="vim ~/.zshrc; zshreload"
alias zshall="vim ~/.config/zsh; zshreload"
alias tmuxconfig="vim ~/.tmux.conf"
alias it="git"
alias rsearch="be rails routes | rg $@"
alias be="bundle exec"
alias bi="bundle install"
alias bb="bundle install"
alias bmig="bin/rails rails g migration $@"
alias pgsql="psql postgres"
alias brc="bin/rails c"
alias mrs="bundle exec rails s -p 3001"
alias mig="LOAD_PLUGINS=1 bundle exec rake db:migrate RAILS_ENV=test && LOAD_PLUGINS=1 bundle exec rake db:migrate"
alias mm="bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:migrate"
alias rollback="bundle exec rake db:rollback RAILS_ENV=test && bundle exec rake db:rollback"
alias gadd='git add "$({ git --no-pager diff --name-only; git ls-files --others --exclude-standard } | fzf)"'
alias grest='git restore "$({ git --no-pager diff --name-only; git ls-files --others --exclude-standard } | fzf)"'
alias gp='git add -p'
alias gap='git add -p'
alias gapp='git add -p "$({ git --no-pager diff --name-only; git ls-files --others --exclude-standard  } | fzf)"'
alias chkfile='git checkout -- "$({ git --no-pager diff --name-only; git ls-files --others --exclude-standard } | fzf)"'
alias gunstage='git reset "$(git --no-pager diff --name-only --cached | fzf)"'
alias gu='git reset "$(git --no-pager diff --name-only --cached | fzf)"'
alias gdiff='git --no-pager diff "$({ git --no-pager diff --name-only; } | fzf)"'
alias gdiffc='git --no-pager diff --cached "$({ git --no-pager diff --name-only --cached; } | fzf)"'
alias vopen='vim $(fzf)'
alias cdiff="git diff-tree -p $@"
alias gmm="git merge main --no-edit"
alias gsl="git stash list"
alias fzcp="fzf | tr -d '\n' | xclip -selection clipboard"

cdd() {
  cd $(fd --type directory | fzf)
}

cc() {
  cd $(fd -i -I -t d -d 1 . $HOME/repos | fzf)
}

cdgems() {
  cd $(fd -i -I -t d -d 1 . $HOME/.gem/ruby/2.7.5/gems | fzf)
}

cdr() {
  cd $(fd -i -I -t d -d 1 . $HOME/repos | fzf)
}

cdc() {
  cd $(fd -i -I -t d -d 1 . $HOME/repos/client-work | fzf)
}

cdf() {
  cd $(fd -i -I -t d -d 1 . $HOME/forge | fzf)
}

cdb() {
  cd $(fd -i -I -t d -d 1 . $HOME/bin | fzf)
}

cda() {
  cd $(fd -i -I -t d -d 1 . $HOME | fzf)
}

lastcommitmsg() {
  git log -1 --pretty=%B | sed -z 's/\n/ /g' | sed -z 's/   / /g'
}

chk() {
  local branches branch
  branches=$(git branch -a) &&
  branch=$(echo "$branches" | fzf +s +m -e) &&
  git checkout $(echo "$branch" | sed "s:.* remotes/origin/::" | sed "s:.* ::")
}

runmany() {
    number=$1
    shift
    for i in `seq $number`; do
      $@
    done
}

chkpr() {
  git fetch origin pull/$@/head:pr/$@ && git checkout pr/$@
}

branchlog() {
  git --no-pager log --no-merges master..$(git rev-parse --abbrev-ref HEAD) --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cD) %C(bold blue)<%an>%Creset' --abbrev-commit
}

gpush() {
  git push --set-upstream origin "$(git branch | grep \* | cut -d ' ' -f2)"
}

gpushr() {
  gpush && gh pr create -w -f
}

ghprc() {
  gh pr create -w -f
}

gblameline() {
  git blame -L$1,$1 -- $2
}

scratchfile() {
  vim ~/scratch/$(echo $(date +%Y-%m-%d-%H-%M-))$@.md
}

newscript() {
  touch $1 && chmod +x $1
}

pasteimg() {
  xclip -selection clipboard -t image/png -o > "$(date +%Y-%m-%d_%T).png"
}

cdgem() {
  gempath=$(bundle show $@)
  cd $gempath
}

commurl() {
  local url=${$(git remote get-url origin)//git@github.com:/https://github.com/}
  url=${url//.git//}
  final="$url""commit/""$@"
  echo $final | xclip -selection clipboard
}

dockerstop() {
  docker stop $(docker ps -aq)
}

allplugrg() {
  rg $1 ~/allthe/all-the-plugins
}

stashm() {
  git stash push -m $@
}

stm() {
  git add . && git stash push -m $@
}

gfl() {
  git log -p $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

gclone() {
  git clone "$1" && cd "$(basename $1)";
}

gclonerepo() {
  git clone "git@github.com:$1"
}

dumptestdb() {
  RAILS_ENV=test bin/rake db:drop db:create db:migrate
}
dumpparatestdb() {
  RAILS_ENV=test bin/rake parallel:drop parallel:create parallel:migrate
}

cdgem() {
  cd $(bundle show $1)
}

streefixer() {
  bundle exec stree write $(git --no-pager diff --name-only --cached -- '*.rb')
}

comurl() {
  echo "$(git config --get remote.origin.url | sed -e 's/\.git$//g' | sed -e 's/:/\//g' | sed -e 's/git@/https:\/\//g')/commit/$1"
}


gcbi() {
  git checkout -b issue/$1
}
gcbf() {
  git checkout -b feature/$1
}
gcbd() {
  git checkout -b dev/$1
}

export EDITOR='vim'

if [ -S $SSH_AUTH_SOCK ]; then
  ssh-add -l | grep "The agent has no identities" && ssh-add
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load seperated config files
for conf in "$HOME/.config/zsh/"*.zsh; do
  source "${conf}"
done
unset conf

# Remove ctrl-t binding fzf
bindkey -r "^T"
bindkey -r "^[T"
