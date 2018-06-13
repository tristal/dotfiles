Windows (Power Admin Prompt):

    cd $env:USERPROFILE; rm -recurse -force .dotfiles; git clone https://github.com/tristal/dotfiles.git .dotfiles; .\.dotfiles\setup.ps1