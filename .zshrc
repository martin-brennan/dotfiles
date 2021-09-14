# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/home/mb/scripts:/home/mb/repos/ops/bin:$HOME/.local/bin:/usr/local/go/bin:/home/mb/go/bin:$PATH

# dolphine file manager stuff
[ "$XDG_CURRENT_DESKTOP" = "KDE"  ] || [ "$XDG_CURRENT_DESKTOP" = "GNOME"  ] || export QT_QPA_PLATFORMTHEME="qt5ct"

export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_AWT_WM_NONREPARTENTING=1
export HYDRA_URL=http://127.0.0.1:4444
export HYDRA_ADMIN_URL=http://127.0.0.1:4445
export GOPATH=$HOME/go
# Path to your oh-my-zsh installation.
export PGROOT="/var/lib/postgres"
export ZSH='/home/mb/.oh-my-zsh'
export FZF_DEFAULT_COMMAND="rg --files --hidden -g '!.git'"
export SSH_ASKPASS='/usr/bin/ksshaskpass'
export GIT_ASKPASS='/usr/bin/ksshaskpass'
export DISCOURSE_REPO_BASE_DIRECTORY='/home/mb/repos'
export DOCKER_GATEWAY_HOST=172.17.0.1
export FZF_DOCKER_PS_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Image}}\t{{.Ports}}"
export FZF_DOCKER_PS_START_FORMAT="table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}"
export VIM_AUTOSPEC=1
export BAT_THEME="gruvbox-dark"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

export RIPGREP_CONFIG_PATH="$HOME/.ripgrep"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-docker)

source $ZSH/oh-my-zsh.sh
source /usr/share/nvm/init-nvm.sh

# https://gist.github.com/gustavohenrique/5721719
alias lspec="bat ~/scripts/last_spec.txt"
alias amend="git commit --amend"
alias bimig="bundle install && RAILS_ENV=test bundle exec rake db:migrate && RAILS_ENV=development bundle exec rake db:migrate"
alias ddmaster="cd ~/repos/master/discourse"
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
alias mixer="ncpamixer"
alias tt="tmux"
alias killconsul="kill -9 $(pidof consul)"
alias killnomad="kill -9 $(pidof nomad)"
alias forge="cd ~/forge"
alias ss="cd ~/scripts"
alias sps="sudo pacman -S"
alias irb="pry"
alias dcu="docker-compose up"
alias mkdir="mkdir -p "
alias imaplog="tail -f log/development.log | grep -e 'EmailSync' -e '\[IMAP\]'"
alias imapgmail="openssl s_client -crlf -connect imap.gmail.com:993"
alias imapoutlook="openssl s_client -crlf -connect outlook.office365.com:993"
alias gfix="git add . && git commit"
alias cdap="cd ~/all-the-plugins"
alias cdr='cd "$(fd -i -I -t d -d 1 . /home/mb/repos | fzf)"'
alias cdc='cd "$(fd -i -I -t d -d 1 . /home/mb/repos/client-work | fzf)"'
alias cdf='cd "$(fd -i -I -t d -d 1 . /home/mb/forge | fzf)"'
alias cdb='cd "$(fd -i -I -t d -d 1 . /home/mb/bin | fzf)"'
alias cda='cd "$(fd -i -I -t d -d 1 . /home/mb | fzf)"'
alias dd="cd ~/repos/discourse"
alias escaps="setxkbmap -option caps:swapescape"
alias vimrc="vim ~/.vimrc"
alias debugspec="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=debug bundle exec rspec $@"
alias debugspecwarn="RAILS_ENABLE_TEST_LOG=true RAILS_TEST_LOG_LEVEL=warn bundle exec rspec $@"
alias chm="git checkout master"
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
alias gpl="git pull"
alias lefthooklint="npx lefthook run lints"
alias zshreload="source ~/.zshrc"
alias zz="zshreload"
alias v="vim"
alias zshconfig="vim ~/.zshrc; zshreload"
alias tmuxconfig="vim ~/.tmux.conf"
alias it="git"
alias rsearch="be rake routes | rg $@"
alias be="bundle exec"
alias bi="bundle install"
alias bmig="be rails g migration $@"
alias pgsql="psql postgres"
alias brc="be rails c"
alias mrs="bundle exec rails s -p 3001"
alias eus="bin/ember-cli -u BETTER_ERRORS=1 RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=0 DISCOURSE_DEV_LOG_LEVEL="info" UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1"
alias usnolog="NO_EMBER_CLI=1 BETTER_ERRORS=1 RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=0 DISCOURSE_DEV_LOG_LEVEL=\"info\" UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1 UNICORN_PORT=3000 bin/unicorn"
alias eusnolog="BETTER_ERRORS=1 RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=0 DISCOURSE_DEV_LOG_LEVEL=\"info\" UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1 UNICORN_PORT=3000 bin/unicorn"
alias us="NO_EMBER_CLI=1 RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=1 UNICORN_TIMEOUT=99999 UNICORN_WORKERS=2 UNICORN_PORT=3000 bin/unicorn"
alias drs="bundle install && RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=1 UNICORN_TIMEOUT=99999 UNICORN_WORKERS=2 bundle exec rails s"
alias drsdebug="BETTER_ERRORS=true RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=1 UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1 bundle exec rails s"
alias drsq="BETTER_ERRORS=true DISABLE_MINI_PROFILER=1 RAILS_COLORIZE_LOGGING=1 UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1 bundle exec rails s"
alias drsnolog="BETTER_ERRORS=true  RAILS_COLORIZE_LOGGING=1 RAILS_VERBOSE_QUERY_LOGS=0 DISCOURSE_DEV_LOG_LEVEL=\"warn\" UNICORN_TIMEOUT=99999 UNICORN_WORKERS=2 bundle exec rails s"
alias drsimap="BETTER_ERRORS=true DISCOURSE_DEV_LOG_LEVEL=\"debug\" DISCOURSE_ENABLE_EMAIL_SYNC_DEMON=true DEBUG_IMAP=true RAILS_VERBOSE_QUERY_LOGS=0 DISCOURSE_DEV_LOG_LEVEL=\"warn\" RAILS_COLORIZE_LOGGING=1 UNICORN_TIMEOUT=99999 UNICORN_WORKERS=1 bundle exec rails s"
alias mig="bundle exec rake db:migrate RAILS_ENV=test && bundle exec rake db:migrate"
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

cdd() {
  cd $(fd --type directory | fzf)
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

gblameline() {
  git blame -L$1,$1 -- $2
}

scratchfile() {
  vim ~/scratch/$(echo $(date +%Y-%m-%d-%H-%M-))$@.md
}

mdeploys() {
  while [ 1 ]
  do
    m deploy-status
    sleep 10
    clear
  done
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
  rg $1 ~/all-the-plugins
}

stashm() {
  git stash push -m $@
}

gfl() {
  git log -p $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export EDITOR='vim'

if [ -S $SSH_AUTH_SOCK ]; then
    ssh-add -l | grep "The agent has no identities" && ssh-add
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
if [ -n "$BASH_VERSION" ] || [ -n "$ZSH_VERSION" ]; then
  source /usr/share/fzf/key-bindings.zsh
  source /usr/share/fzf/completion.zsh
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh
  chruby ruby-2.7.1
fi
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#         source /etc/profile.d/vte.sh
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if [[ $PWD == "/home/mb" ]]
then
  cd ~/repos
fi

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec startx
fi

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
  tmux
fi

