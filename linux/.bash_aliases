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
alias spt='speedtest --bytes'
alias ls='lsd'
# alias batThemes='bat --list-themes | fzf --preview="bat --theme={} --color=always ~/.theme_preview.ts"'
alias tree='eza -aT --color=always --group-directories-first --icons'

# alias reload
# Set up 'report' alias for sharing configuration files with Zorin help
# Use it like this:
# dmesg | report
# cat /etc/default/grub | report
alias report="curl -F 'file=@-' 0x0.st"
alias lzd='lazydocker'
alias gkk='open -na "GitKraken" --args -p $(pwd)'
alias ff='fzf --preview "bat {-1} --color=always"'
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

fd() {
  root=$(git rev-parse --show-toplevel)
  if [ -n "$root" ]; then
    pushd "$root"
    preview="git diff $@ --color=always -- {-1}"
    git diff $@ --name-only | fzf -m --ansi --preview $preview
    popd
  fi
}

fst() {
  root=$(git rev-parse --show-toplevel)
  if [ -n "$root" ]; then
    pushd "$root"
    preview="git diff $@ --color=always -- {-1}"
    git status -s | fzf --no-sort --reverse \
      --preview 'git diff --color=always {+2} | bat --color=always --style=header,grid --line-range :300 --file-name {+2}' \
      --bind=ctrl-j:preview-down --bind=ctrl-k:preview-up \
      --preview-window=right:60%:wrap
    popd
  fi
}

gck() {
  # Select the branch (strip leading spaces or stars)
  selected_branch=$(git branch -a | fzf | sed 's/^[* ]*//')

  # Exit if no branch is selected
  if [ -z "$selected_branch" ]; then
    echo "No branch selected."
    return 1
  fi

  # If it's a remote branch
  if [[ "$selected_branch" =~ ^remotes/origin/ ]]; then
    # Get the local branch name by stripping the 'remotes/origin/' prefix
    local_branch="${selected_branch#remotes/origin/}"

    # Check if the local branch already exists
    if git show-ref --verify --quiet "refs/heads/$local_branch"; then
      # If it exists, checkout the local branch
      echo -e "\033[32mLocal branch '$local_branch' exists. Switching to it...\033[0m"
      git checkout "$local_branch"
    else
      # If it doesn't exist, create and checkout the local branch, tracking the remote
      echo -e "\033[32mChecking out remote branch: $selected_branch as local branch: $local_branch...\033[0m"
      git checkout -b "$local_branch" --track "$selected_branch"
    fi
  else
    # For local branches, just checkout
    echo "Checking out local branch: $selected_branch"
    git checkout "$selected_branch"
  fi
}

connect() {
  case "$1" in

  dev) ssh -i ~/.ssh/re-new-TBTECH-WEB.pem -N -L 5678:zaiko2-dev-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-dev-fd.tbtech.jp ;;

  stg) ssh -i ~/.ssh/re-new-TBTECH-WEB.pem -N -L 5678:zaiko2-stg-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-stg-fd.tbtech.jp ;;

  alydev) ssh -i ~/.ssh/re-new-TBTECH-WEB.pem -N -L 5678:zaiko2-aly-dev-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-aly-dev-fd.tbtech.jp ;;

  alystg) ssh -i ~/.ssh/re-new-TBTECH-WEB.pem -N -L 5678:zaiko2-aly-stg-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-aly-stg-fd.tbtech.jp ;;

  alyprod) ssh -i ~/.ssh/re-new-TBTECH-WEB.pem -N -L 5678:zaiko2-aly-prod-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-aly-prod-fd.tbtech.jp ;;

  *) echo "Usage: connect {dev|stg|alydev|alystg|alyprod}" ;;
  esac
}


count() {
  git shortlog -sn | grep -i "$1" | awk '{sum += $1} END {print sum}'
}


# rm() {
#   echo '⚠️  Hãy dùng "trash" thay thế, ví dụ:'
#   echo
#   echo "  > trash $@"
#   echo
#   echo 'Lệnh rm đã bị vô hiệu hoá để tránh xoá nhầm!'
# }

batThemes() {
  local theme
  theme=$(bat --list-themes | fzf --preview="bat --theme={} --color=always ~/.theme_preview.ts")
  if [ -n "$theme" ]; then
    sed -i.bak -E "s|^--theme=.*|--theme=\"$theme\"|" ~/.config/bat/config
    echo "bat theme set to: $theme"
  else
    echo "No theme selected."
  fi
}


lg() {
  # Nếu không có tham số hoặc tham số đầu tiên bắt đầu bằng '-' (là option)
  if [ $# -eq 0 ] || [[ "$1" == -* ]]; then
    git log "$@" --graph --abbrev-commit --decorate \
      --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' \
      --all
  else
    # Nếu tham số đầu tiên là tên branch (không bắt đầu bằng '-')
    local branch="$1"
    shift  # Bỏ tham số đầu tiên, giữ lại các tham số còn lại

    git log "$@" --graph --abbrev-commit --decorate \
      --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' \
      "$branch" HEAD
  fi
}


check() {
  local branch="${1:-develop}"
  local count="${2:-10}"

  git log $branch..HEAD --oneline --left-right --cherry-pick --color \
    --pretty=format:'%C(yellow)%m%C(reset) %C(blue)%h%C(reset) %C(cyan)%an%C(reset) %C(green)%ar%C(reset) %s%n' \
    | head -n $count
}
