test: create converge verify destroy

init:
	ANSIBLE_ROLES_PATH=../../roles molecule init scenario -r db -d vagrant
create:
	ANSIBLE_ROLES_PATH=../../roles molecule create
destroy:
	ANSIBLE_ROLES_PATH=../../roles molecule destroy
converge:
	ANSIBLE_ROLES_PATH=../../roles molecule converge
verify:
	ANSIBLE_ROLES_PATH=../../roles molecule verify
