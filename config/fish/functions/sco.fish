# Defined in - @ line 1
function sco --description 'alias sco sudo systemctl stop'
	sudo systemctl stop $argv;
end
