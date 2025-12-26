
Invoke-Expression (& { (zoxide init powershell | Out-String) })
Invoke-Expression (&starship init powershell)
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression


function New-DirAndCd {
  param(
    [string]$DirectoryName
  )

  # Create the directory
  New-Item -ItemType Directory -Path $DirectoryName | Out-Null

  # Change to the new directory
  Set-Location $DirectoryName
}
Set-Alias -Name mkcd -Value New-DirAndCd


function Thanh_DA { Set-Location -Path D:\thanh_da }
Set-Alias -Name thanhda -Value Thanh_DA

function M2M { Set-Location -Path D:\m2m }
Set-Alias -Name mtm -Value M2M


function Clone-Git {
  git clone @args
}

function Push-Git {
  git push @args
}

function Status-Git {
  git status @args
}

function Pull-Git {
  git pull @args
}

function Branch-Git {
  git branch @args
}

function Branches-Git {
  git branch -a @args
}

function Checkout-Git {
  git checkout @args
}

function Add-Git {
  git add @args
}

function Add-All-Git {
  git add . @args
}

function Commit-Git {
  git commit @args
}

function Amend-Git {
  git commit --amend @args
}

function Current-Branch-Git {
  git branch --show-current @args
}

function Merge-Git {
  git merge @args
}

function Rebase-Git {
  git rebase @args
}

function Continue-Rebase-Git {
  git rebase --continue @args
}

function Restore-Git {
  git restore @args
}

function Stash-Git {
  git stash @args
}

function Git-Init {
  git init @args
}

function Git-Remote {
  git remote @args
}

Set-Alias -Name clone -Value Clone-Git
Set-Alias -Name push -Value Push-Git
Set-Alias -Name st -Value Status-Git
Set-Alias -Name pull -Value Pull-Git
Set-Alias -Name branch -Value Branch-Git
Set-Alias -Name branches -Value Branches-Git
Set-Alias -Name ck -Value Checkout-Git
Set-Alias -Name add -Value Add-Git
Set-Alias -Name addAll -Value Add-All-Git
Set-Alias -Name cmt -Value Commit-Git
Set-Alias -Name amend -Value Amend-Git
Set-Alias -Name this -Value Current-Branch-Git
Set-Alias -Name merge -Value Merge-Git
Set-Alias -Name rebase -Value Rebase-Git
Set-Alias -Name continue -Value Continue-Rebase-Git
Set-Alias -Name restore -Value Restore-Git
Set-Alias -Name stash -Value Stash-Git
Set-Alias -Name init -Value Git-Init
Set-Alias -Name remote -Value Git-Remote


function Echo-All-params {
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$params
  )

  $mergedParams = $params -join ''
  Write-Output $mergedParams
}

Set-Alias -Name aba -Value Echo-All-params


function Weather-Report($Location) {

  # check if the location is empty
  if ([string]::IsNullOrEmpty($Location)) {
    $Location = "hanoi"
  }

  curl wttr.in/$Location
}
Set-Alias -Name weather -Value Weather-Report


function List-Container-Ids {
  docker container ls -aq
}
Set-Alias -Name psaq -Value List-Container-Ids

Set-Alias -Name cl -Value clear

Set-Alias -Name k -Value kubectl


function List-Context {
  kubectl config get-contexts
}
Set-Alias -Name kctx -Value "kubectl config get-contexts"

function UseContext {
  param(
    [string]$ContextName
  )

  kubectl config use-context $ContextName
}

Set-Alias -Name useContext -Value UseContext

Set-Alias -Name cpToken -Value 'kubectl -n kubernetes-dashboard create token k8sadmin | pbcopy'
Set-Alias -Name delothers -Value 'git branch | grep -v $(this) | xargs git branch -D'
Set-Alias -Name sbtAkka -Value 'sbt new akka/akka-scala-seed.g8'
Set-Alias -Name sbtPure -Value 'sbt new scala/scala-seed.g8'
Set-Alias -Name initMill -Value 'mill -i init com-lihaoyi/mill-scala-hello.g8'

function Set-RelativeAlias {
  param (
    [string]$Path
  )

  return Set-Location $Path
}

# Set aliases for different levels of relative navigation
function .. { Set-RelativeAlias '../' }
function ... { Set-RelativeAlias '../../' }
function .... { Set-RelativeAlias '../../../' }


function LazyDockerCMD {
  lazydocker
}
Set-Alias -Name lzd -Value LazyDockerCMD
