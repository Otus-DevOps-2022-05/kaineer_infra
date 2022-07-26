all:
	ansible-playbook ./playbooks/site.yml
stage:
	ansible-playbook -i ./environments/stage/inventory.py ./playbooks/site.yml
prod:
	ansible-playbook -i ./environments/prod/inventory.py ./playbooks/site.yml

install_roles:
	ANSIBLE_ROLES_PATH=./roles ansible-galaxy install -r ./environments/stage/requirements.yml
