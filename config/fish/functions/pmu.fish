# Defined in - @ line 1
function pmu --description 'alias pmu sudo pacman -Syu'
	sudo pacman -Syu $argv;
end
