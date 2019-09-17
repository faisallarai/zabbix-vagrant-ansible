# Requirements
```
Host (Memory 16GB)
VirtualBox
Vagrant 
Ansible
Internet
```


# How to use it
```
vagrant up
vagrant ssh-config >~/.ssh/config
vagrant plugin install vagrant-disksize
ansible-vault create vault_file.yml 

# vault_file.yml
db_pass: <password>

ansible-playbook -i inventory.yml playbook.yml  --ask-vault-pass
```