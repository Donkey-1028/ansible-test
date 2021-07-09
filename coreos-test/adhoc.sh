echo "Start Create SSH Key"
ansible localhost -m openssh_keypair -a 'path=~/.ssh/id_rsa'
echo "End Create SSH Key"

echo "Create authorized keys dir"
ansible coreos -m file -a 'state=directory path=~/.ssh recurse=yes' -k 
echo "End authorized keys dir"

echo "Start Copy SSH Key"
SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
ansible coreos -m lineinfile -a 'path=~/.ssh/authorized_keys line="{{ ssh_key }}" create=yes' -k -e "ssh_key='$SSH_KEY'"
echo "End Copy SSH Key"
