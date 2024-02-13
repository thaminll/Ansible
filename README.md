# Ansible-tasks

### Add SSH key
#### run these commands to add ssh key :
>
>ssh-keygen

>ssh-copy-id -i ~/.ssh/id_rsa.pub user@[target_server]

## Description

- User Management:
  - Add a new user with an SSH key on the servers.
  - Delete a specific user.

- SSH Configuration:
  - Configure SSH settings such as a new port.
  - Disable root login.
  - Disable password authentication.

- Elasticsearch Configuration:
  - Configure Elasticsearch as a single node with authentication.

- PostgreSQL Installation:
  - Install PostgreSQL 12.
  - Change the default port.
  - Create a database with a specific user and password.
  - Set up necessary permissions for connections from other places.

- Redis Installation:
  - Install Redis.
  - Set up a new password.

- Prometheus Installation:
  - Install Prometheus.
  - Install Node Exporter on the nodes.

- RabbitMQ Installation:
  - Install RabbitMQ.
  - Create a user with a specified password.
  - Create a queue, exchange, binding, etc.

- Kafka Installation:
  - Set up Kafka with at least 3 nodes.

## Run Playbook

> ansible-playbook -i [invemntory/hostfiles] playbook.yml

>  --tags [specific task] --limits [host]

ansible-playbook -i [invemntory/hostfiles] playbook.yml

#### for running an specific task or host we can use:
 --tags [specific task] --limits [host]
