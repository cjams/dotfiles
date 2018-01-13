function pmr -d "Remove package(s) from the repositories"
    sudo pacman -R -s $argv
end
