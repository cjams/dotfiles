# Defined in - @ line 1
function pmi --description 'alias pmi sudo pacman -S'
	sudo pacman -S $argv;
end
