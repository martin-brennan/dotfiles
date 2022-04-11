# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/mb/scripts:/home/mb/repos/ops/bin:$HOME/.local/bin:/usr/local/go/bin:/home/mb/go/bin:$PATH

# dolphin file manager stuff
[ "$XDG_CURRENT_DESKTOP" = "KDE"  ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME"  ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARTENTING=1
export HYDRA_URL=http://127.0.0.1:4444
export HYDRA_ADMIN_URL=http://127.0.0.1:4445
export GOPATH=$HOME/go
export PGROOT="/var/lib/postgres"
export ZSH="$HOME/.oh-my-zsh"
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"
export SSH_ASKPASS='/usr/bin/ksshaskpass'
export GIT_ASKPASS='/usr/bin/ksshaskpass'
export REPO_BASE_DIRECTORY="$HOME/repos"
export DISCOURSE_REPO_BASE_DIRECTORY=$REPO_BASE_DIRECTORY
export DOCKER_GATEWAY_HOST=172.17.0.1
export HUB_BASE_URL="http://localhost:3002/api"
export FZF_DOCKER_PS_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
export FZF_DOCKER_PS_START_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
export VIM_AUTOSPEC=1
export BAT_THEME="gruvbox-dark"
export RIPGREP_CONFIG_PATH="$HOME/.ripgrep"

# Enter instead of ^M
stty icrnl

# zsh config
ZSH_THEME="robbyrussell"
plugins=(git fzf-docker)
source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

alias chrome="chromium"
alias lspec="bat ~/scripts/last_spec.txt"
alias revfix="git commit -m \"DEV: Review fixes\""
alias specfix="git commit -m \"DEV: Test fix\""
alias lintfix="git commit -m \"DEV: Lint\""
alias amend="git commit --amend"
alias bimig="bundle install && RAILS_ENV=test bundle exec rake db:migrate && RAILS_ENV=development bundle exec rake db:migrate"
alias ddmaster="cd $REPO_BASE_DIRECTORY/master/discourse"
alias gpickaxe="git log -p -S $@"
alias rrm="fzf | xargs -I '{}' rm {}"
alias down="cd ~/Downloads"
alias ccat="pygmentize -f terminal256 -P style=monokai -g $@"
alias dwmcfg="forge && cd dwm && vim config.h"
alias dmenucfg="forge && cd dmenu && vim config.h"
alias stcfg="forge && cd st && vim config.h"
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
alias debugspec="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=debug bundle exec rspec $@"
alias debugspecwarn="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=warn bundle exec rspec $@"
alias chmp="git checkout master && git pull"
alias chma="git checkout main && git pull"
alias annotatemodels="bundle exec annotate"
alias plugspec="IMPROVED_SPEC_DEBUGGING=1 LOAD_PLUGINS=1 be rspec $@"
alias masterfile="git checkout origin/master -- $@"
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
alias cc="cdr"
alias v="vim"
alias zshconfig="vim ~/.zshrc; zshreload"
alias tmuxconfig="vim ~/.tmux.conf"
alias it="git"
alias rsearch="be rails routes | rg $@"
alias be="bundle exec"
alias bi="bundle install"
alias bb="bundle install"
alias bmig="be rails g migration $@"
alias pgsql="psql postgres"
alias brc="be rails c"
alias mrs="bundle exec rails s -p 3001"
alias mig="bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:migrate"
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
alias gmm="git merge main"
alias gsl="git stash list"
alias fzcp="fzf | tr -d '\n' | xclip -selection clipboard"

cdd() {
  cd $(fd --type directory | fzf)
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

gbb() {
  git push --set-upstream origin "$(git branch | grep \* | cut -d ' ' -f2)"
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

ccu() {
  local commit=$(git log --color=always --format="%C(green bold)%H%Creset %C(yellow)[%ad]%Creset %C(white bold)%s%Creset %Cblue[%an]%Creset" --date=format:%Y-%m-%d | fzf --no-sort --ansi --multi)
  commit=(${(@s/ /)commit})
  if [[ -n "${commit[1]/[ ]*\n/}" ]]
  then
    local url=${$(git remote get-url origin)//git@github.com:/https://github.com/}
    url=${url//.git//}
    final="$url""commit/""$commit[1]"
    echo $final | xclip -selection clipboard
    git --no-pager show --pretty=medium -s --color=always $commit[1]
  fi
}

ccuc() {
  local commit=$(git log --color=always --format="%C(green bold)%H%Creset %C(yellow)[%ad]%Creset %C(white bold)%s%Creset %Cblue[%an]%Creset" --date=format:%Y-%m-%d | fzf --no-sort --ansi --multi)
  commit=(${(@s/ /)commit})
  if [[ -n "${commit[1]/[ ]*\n/}" ]]
  then
    echo $commit[1] | xclip -selection clipboard
    git --no-pager show --pretty=medium -s --color=always $commit[1]
  fi
}

ccume() {
  local commit=$(git log --author="Martin Brennan" --color=always --format="%C(green bold)%H%Creset %C(yellow)[%ad]%Creset %C(white bold)%s%Creset %Cblue[%an]%Creset" --date=format:%Y-%m-%d | fzf --no-sort --ansi --multi)
  commit=(${(@s/ /)commit})
  if [[ -n "${commit[1]/[ ]*\n/}" ]]
  then
    local url=${$(git remote get-url origin)//git@github.com:/https://github.com/}
    url=${url//.git//}
    final="$url""commit/""$commit[1]"
    echo $final | xclip -selection clipboard
    git --no-pager show --pretty=medium -s --color=always $commit[1]
  fi
}

ccumec() {
  local commit=$(git log --author="Martin Brennan" --color=always --format="%C(green bold)%H%Creset %C(yellow)[%ad]%Creset %C(white bold)%s%Creset %Cblue[%an]%Creset" --date=format:%Y-%m-%d | fzf --no-sort --ansi --multi)
  commit=(${(@s/ /)commit})
  if [[ -n "${commit[1]/[ ]*\n/}" ]]
  then
    echo $commit[1] | xclip -selection clipboard
    git --no-pager show --pretty=medium -s --color=always $commit[1]
  fi
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

export EDITOR='vim'

if [ -S $SSH_AUTH_SOCK ]; then
  ssh-add -l | grep "The agent has no identities" && ssh-add
fi

if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.7.1
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
