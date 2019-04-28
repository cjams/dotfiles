# Defined in - @ line 1
function sca --description 'alias sca sudo systemctl start'
	sudo systemctl start $argv;
end
