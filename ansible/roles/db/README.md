DB
==

Role to set up database host.


Role Variables
--------------

mongo\_bind\_ip - which ip mongo service should be binded to
mongo\_port - port for mongo service

Example Playbook
----------------

```yaml
- hosts: db
  roles:
	  - { role: db, mongo_bind_ip: 0.0.0.0 }
```

License
-------

MIT

Author Information
------------------

Sergey Kluchkovsky, student of OTUS class «DevOps, practices and tools»
