# $env:ANTHROPIC_BASE_URL = "https://chat.trollllm.xyz"
# $env:ANTHROPIC_API_KEY = "sk-trollllm-e80828e4e36b5250c07711557787eb98021e85f56b137e856919425a39df733b"
# $env:ANTHROPIC_DEFAULT_SONNET_MODEL = "claude-sonnet-4-5-20250929"
# $env:ANTHROPIC_DEFAULT_OPUS_MODEL = "claude-opus-4-5-20251101"
# $env:ANTHROPIC_DEFAULT_HAIKU_MODEL = "gpt-5.1-codex-max"
# $env:CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1"
$env:EDITOR = "code --wait"

Invoke-Expression (&starship init powershell)
fnm env --use-on-cd --shell powershell | Out-String | Invoke-Expression


function New-DirAndCd
{
  param(
    [string]$DirectoryName
  )

  # Create the directory
  New-Item -ItemType Directory -Path $DirectoryName | Out-Null

  # Change to the new directory
  Set-Location $DirectoryName
}
Set-Alias -Name mkcd -Value New-DirAndCd


function Thanh_DA
{ Set-Location -Path D:\thanh_da
}
Set-Alias -Name thanhda -Value Thanh_DA

function M2M
{ Set-Location -Path D:\m2m
}
Set-Alias -Name mtm -Value M2M


function Clone-Git
{
  git clone @args
}

function Push-Git
{
  git push @args
}

function Status-Git
{
  git status @args
}

function Pull-Git
{
  git pull @args
}

function Branch-Git
{
  git branch @args
}

function Branches-Git
{
  git branch -a @args
}

function Checkout-Git
{
  git checkout @args
}

function Checkout-Branch-Picker-Git
{
  $selectedBranch = git branch -a | fzf

  if ([string]::IsNullOrWhiteSpace($selectedBranch))
  {
    Write-Output "No branch selected."
    return 1
  }

  $selectedBranch = ($selectedBranch.Trim()) -replace '^[* ]*', ''

  if ($selectedBranch -match '^remotes/origin/')
  {
    $localBranch = $selectedBranch -replace '^remotes/origin/', ''

    git show-ref --verify --quiet "refs/heads/$localBranch" *> $null

    if ($LASTEXITCODE -eq 0)
    {
      Write-Host "Local branch '$localBranch' exists. Switching to it..." -ForegroundColor Green
      git checkout "$localBranch"
    }
    else
    {
      Write-Host "Checking out remote branch: $selectedBranch as local branch: $localBranch..." -ForegroundColor Green
      git checkout -b "$localBranch" --track "$selectedBranch"
    }
  }
  else
  {
    Write-Output "Checking out local branch: $selectedBranch"
    git checkout "$selectedBranch"
  }
}

function Add-Git
{
  git add @args
}

function Add-All-Git
{
  git add . @args
}

function Commit-Git
{
  git commit @args
}

function Amend-Git
{
  git commit --amend @args
}

function Current-Branch-Git
{
  git branch --show-current @args
}

function Merge-Git
{
  git merge @args
}

function Rebase-Git
{
  git rebase @args
}

function Continue-Rebase-Git
{
  git rebase --continue @args
}

function Restore-Git
{
  git restore @args
}

function Stash-Git
{
  git stash @args
}

function Git-Init
{
  git init @args
}

function Git-Remote
{
  git remote @args
}

Set-Alias -Name clone -Value Clone-Git
Set-Alias -Name push -Value Push-Git
Set-Alias -Name st -Value Status-Git
Set-Alias -Name pull -Value Pull-Git
Set-Alias -Name branch -Value Branch-Git
Set-Alias -Name branches -Value Branches-Git
Set-Alias -Name ck -Value Checkout-Git
Set-Alias -Name gck -Value Checkout-Branch-Picker-Git
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


function Echo-All-params
{
  param(
    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$params
  )

  $mergedParams = $params -join ''
  Write-Output $mergedParams
}

Set-Alias -Name aba -Value Echo-All-params


function Weather-Report($Location)
{

  # check if the location is empty
  if ([string]::IsNullOrEmpty($Location))
  {
    $Location = "hanoi"
  }

  curl wttr.in/$Location
}
Set-Alias -Name weather -Value Weather-Report


function List-Container-Ids
{
  docker container ls -aq
}
Set-Alias -Name psaq -Value List-Container-Ids

Set-Alias -Name cl -Value clear

Set-Alias -Name k -Value kubectl


function List-Context
{
  kubectl config get-contexts
}
Set-Alias -Name kctx -Value "kubectl config get-contexts"

function UseContext
{
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

function Set-RelativeAlias
{
  param (
    [string]$Path
  )

  return Set-Location $Path
}

# Set aliases for different levels of relative navigation
function ..
{ Set-RelativeAlias '../'
}
function ...
{ Set-RelativeAlias '../../'
}
function ....
{ Set-RelativeAlias '../../../'
}


function LazyDockerCMD
{
  lazydocker
}
Set-Alias -Name lzd -Value LazyDockerCMD


function Log
{
  git log -6 --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'   develop HEAD # <== khác biệt chính nằm ở đây
}
Set-Alias -Name lg -Value Log
Import-Module syntax-highlighting

Invoke-Expression (& { (zoxide init powershell | Out-String) })


function TptConnect
{
  ssh -i C:\Users\thanh_da\.ssh\TBTECH-WEB.pem -N -L 5432:zaiko2-dev-db-cluster.cluster-cew5zi16dxpx.ap-northeast-1.rds.amazonaws.com:5432 ec2-user@zaiko2-dev-fd.tbtech.jp
}
Set-Alias -Name tpt -Value TptConnect
