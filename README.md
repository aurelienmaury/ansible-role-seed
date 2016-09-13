# Ansible role: seed

This role is meant to be the first contact after a successfull execution of the `ping` module on 
a managed host. It will install ansible itself and some dependencies to enable most ansible module
execution. 

Add this to your `requirements.yml`:
```
- src: https://github.com/aurelienmaury/ansible-role-seed.git
  name: seed
```
