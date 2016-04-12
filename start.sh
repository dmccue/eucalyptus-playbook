#!/bin/bash

ssh-add
[ "$1" == "reset" ] && ssh dixonscpw 'rm -rf ~/dixons_prod'
ansible-lint play.yml && rsync -av ../dixons_prod dixonscpw:~/
ssh dixonscpw "rm -rf ~/.ssh/mux-*"
ssh -t dixonscpw "cd ~/dixons_prod && ansible-playbook -i hosts play.yml"

#ssh -t dixonscpw "cd ~/dixons_prod && ansible -i hosts all -m shell -a 'whoami'"
#ansible -i hosts all -K -m shell -a 'whoami'
