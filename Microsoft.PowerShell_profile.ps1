# Set-ExecutionPolicy unrestricted

$downloads = "C:\Users\trist\Downloads"
$src = "C:\Users\trist\src"

function up {
    cd ..
}

function hosts {
    vim C:\Windows\system32\drivers\etc\hosts
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
