alias lf="ls -l | egrep -v '^d'"
alias ldir='ls -d */'
alias clone='git clone'
alias push='git push'
alias st='git status'
alias pull='git pull'
alias branch='git branch'
# alias branches='git branch -a'
alias ck='git checkout'
alias add='git add'
alias addAll='git add .'
alias cmt='git commit'
alias this='git branch --show-current'
alias merge='git merge'
alias rebase='git rebase'
alias continue='git rebase --continue'
alias restore='git restore'
alias stash='git stash'
alias weather='curl wttr.in/hanoi'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias init='git init'
alias remote='git remote'
alias psaq='docker container ls -aq'
alias ll='ls -a'
alias fetch='git fetch'
alias crdev='ssh -p 3638 -fNg -L 54320:10.99.28.58:5432 thanh_da@35.76.9.233'
alias crstg='ssh -p 3638 -fNg -L 54321:10.99.33.225:5432 thanh_da@35.76.9.233'
alias cralydev='./cloud_sql_proxy -instances=pyxis-enterprise:asia-northeast1:digdag-ee-dev=tcp:3367,pyxis-enterprise:asia-northeast1:pyxisee-dev=tcp:5434'
alias cralystg='./cloud_sql_proxy -instances=pyxis-enterprise:asia-northeast1:prod-4398-check-clone=tcp:5555'
alias cralyprod='./cloud_sql_proxy -instances=pyxis-enterprise:asia-northeast1:digdag-ee-prod=tcp:3366,pyxis-enterprise:asia-northeast1:pyxisee-prod=tcp:5433'
alias cl='clear'
alias hist='vim ~/.bash_history'
alias cdcr='cd ~/Documents/Flinters/project/customed_report'
alias cdcraly='cd ~/Documents/Flinters/project/craly'
alias cded='cd ~/Documents/ANP'
alias thanhda='cd ~/Documents/ANP'
alias k=kubectl
alias kgd='kubectl get deployment'
alias getContexts="kubectl config get-contexts"
alias useContext="kubectl config use-context"
alias setContext="kubectl config set-context"
alias cpToken='kubectl -n kubernetes-dashboard create token k8sadmin | pbcopy'
alias delothers='git branch | grep -v $(this) | xargs git branch -D'
alias sbtAkka='sbt new akka/akka-scala-seed.g8'
alias sbtPure='sbt new scala/scala-seed.g8'
alias initMill='mill -i init com-lihaoyi/mill-scala-hello.g8'
alias spt='speedtest -u MB/s'
alias ls='lsd'
alias batThemes='bat --list-themes | fzf --preview="bat --theme={} --color=always ~/.theme_preview.ts"'

# alias reload
# Set up 'report' alias for sharing configuration files with Zorin help
# Use it like this:
# dmesg | report
# cat /etc/default/grub | report
alias report="curl -F 'file=@-' 0x0.st"
alias lzd='lazydocker'

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'

reload() {
  MY_SHELL=$(ps -p $$ -ocomm=)
  if [[ $MY_SHELL == *"bash"* ]]; then
    source ~/.bashrc
  elif [[ $MY_SHELL == *"zsh"* ]]; then
    source ~/.zshrc
  else
    echo "Unknown shell: $MY_SHELL"
  fi
}

# function rider() {
#   /snap/bin/rider "$1" >/dev/null 2>&1 &
# }

# function wbst() {
#   /snap/bin/webstorm "$1" >/dev/null 2>&1 &
# }

mkcd() {
  case "$1" in
  */.. | */../) cd -- "$1" ;; # that doesn't make any sense unless the directory already exists
  /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1" ;;
  /*) mkdir -p "$1" && cd "$1" ;;
  */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1" ;;
  ../*) (cd .. && mkdir -p "${1#.}") && cd "$1" ;;
  *) mkdir -p "./$1" && cd "./$1" ;;
  esac
}

branches() {
  git branch "$@" --sort=-committerdate --sort=-HEAD --format=$'%(HEAD) %(color:yellow)%(refname:short) %(color:green)(%(committerdate:relative))\t%(color:blue)%(subject)%(color:reset)' --color=$(__fzf_git_color) | column -ts$'\t'
}
