# Defined in - @ line 1
function sce --description 'alias sce sudo systemctl enable'
	sudo systemctl enable $argv;
end
