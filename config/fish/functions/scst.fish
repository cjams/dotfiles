# Defined in - @ line 1
function scst --description 'alias scst sudo systemctl status'
	sudo systemctl status $argv;
end
