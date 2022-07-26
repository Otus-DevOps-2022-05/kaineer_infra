all:
	ansible-playbook ./playbooks/site.yml

prod:
	ansible-playbook -i ./environments/prod/inventory.py ./playbooks/site.yml
