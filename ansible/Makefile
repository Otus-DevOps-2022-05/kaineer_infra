all:
	ansible-playbook site.yml

oneplay:
	ansible-playbook reddit_app.yml --limit db --tags db-tag
	ansible-playbook reddit_app.yml --limit app --tags app-tag

onebook:
	ansible-playbook reddit_app2.yml

manybooks:
	ansible-playbook db.yml
	ansible-playbook app.yml
	ansible-playbook deploy.yml
