# Set-ExecutionPolicy unrestricted

$downloads = "C:\Users\trist\Downloads"
$src = "C:\Users\trist\src"

function list-alias {
    Write-Host "up        => cd .."
    Write-Host "hosts     => notepad .../etc/hosts"
    Write-Host "rm-rf     => ..."
    Write-Host "printenv  => print env vars"
    Write-Host "src       => cd $src"
    Write-Host "gitpr     => create PR for current branch"
    Write-Host "gitclean  => clean local branches"
    Write-Host "gitup     => push to remote"
    Write-Host "gg        => print current branch"
}

function up {
    cd ..
}

function hosts {
    notepad C:\Windows\system32\drivers\etc\hosts
}

function rm-rf {
    if ($args) {
        rm -re -fo $args
    }
}

function printenv {
     Get-ChildItem env:
}

function src {
    cd $src
}

# create pr from current branch, will open github page.
function gitpr() {
    if (-not (Test-Path .git)) {
        Write-Host "This is not a git repo" -f red
        return
    }
    
    $remoteUrl = (git config --get remote.origin.url).trim('.git')
    Write-Host "Remote: $remoteUrl" -f green

    $currentBranch = git rev-parse --abbrev-ref HEAD
    $currentBranch = $currentBranch.trim()
    Write-Host "Current branch: $currentBranch" -f green

    start "$remoteUrl/tree/$currentBranch"
}

# clean local branch that deleted remotely
function gitclean {
    $currentBranch = git symbolic-ref --short HEAD
    $currentBranch = $currentBranch.Trim()
    git remote prune origin
    $branches = git branch --merged | ?{!($_ -like "*master*" -or $_ -like "*develop*" -or $_ -like "*$currentBranch*")}

    if ($branches.count -gt 0) {
        Write-Host "Clean branches: "
        $branches | %{ Write-Host $_ -f yellow }
        $branches.trim() | %{ git branch -d $_ } 
    }
}

function gitup() {
    # git push --set-upstream origin feature/abc

    $currentBranch = git symbolic-ref --short HEAD
    $currentBranch = $currentBranch.trim()
    Write-Host "Current branch: <$currentBranch>" -f green

    git push --set-upstream origin $currentBranch
}

#short cmd to get current branch
function gg() {
    $currentBranch = git symbolic-ref --short HEAD
    Write-Host "Current branch: <$currentBranch>" -f green
}