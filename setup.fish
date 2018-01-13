#!/usr/bin/fish

fisher z edc/bass
ssh-add

if [ ! -e $HOME/.ssh/id_rsa ];
then
    ssh-keygen
    sudo cp -v /etc/ssh/ssh_config $HOME/.ssh/config
    echo "AddKeysToAgent = confirm" >> $HOME/.ssh/config
fi
