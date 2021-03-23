# Nginx-Nodejs-MondoDB

## Tools Used

Cloud Provider - AWS  
Infrastructure - Terraform v0.14.5  
Configuration Management - Ansible 2.10.4  

### What will be deployed

- Region
   - Frankfurt (eu-central-1)
- Networking
   - 1 VPC
   - 1 Internet Gateway
   - 1 Nat Gateway
   - 3 Public Subnets
   - 3 Private Subnets
   - 7 Security Groups
   - 4 Elastic IPs

- Compute
    - 1 Key Pair (common to all servers/ added to the repository)
    - 1 VPN server (Pritunl)
    - 3 DB servers (One on each AZ)
    - 2 Launch configurations (NGINX and NodeJS)
    - 2 Auto Scaling Groups (NGINX and NodeJS)
    - 1 Classic LoadBalancer (NodeJS)
    - 1 Application LoadBalancer (NGINX)

### AWS

To configure your local machine to work with AWS, update as follows

Add the following to `/.aws/credentials`

```
[default]
aws_access_key_id = <AWS_ACCESS_KEY>
aws_secret_access_key = <AWS_SECRET_KEY>
```

Add the following to `/.aws/config`

```
[default]
region = eu-central-1
```

### Terraform

#### Prerequisites

```
$ git clone <repo>
$ cd <repo>/terraform/
$ vi terraform.tfvars
```

Change the following variables

```
local_ip = "<local_machine_ip>"
public_key_path = "<ssh_key_path>"

```
#### RUN

```
$ terraform init
$ terraform plan
# When apply the aboveplan
$ terraform apply
# To destroy your stack
$ terraform destroy
```

### Ansible

#### VPN

Configure the hosts file to run Pritunl VPN on VPN Server

```
$ cd <repo>/ansible/vpnserver
$ vi hosts
 [vpnserver]
 <vpnserver_ip> #public_ip from AWS console 
$ ansible-playbook vpnserver-setup.yaml -i hosts
```

#### MongoDB

Configure the hosts.yaml file to install and configure mongodb and replicationset

Get the following details from AWS and update in `hosts.yaml`

- `host_name`: The name of the host. Example: mongo-1
- `host_ip`: The public IP of your host. Example: 52.29.21.17
- `host_private_ip`: The public IP of your host. Example: 10.0.20.241
- `public_dns`: Update the public DNS as hosts. Example: ec2-52-29-21-17.eu-central-1.compute.amazonaws.com

```
$ cd <repo>/ansible/mongodb
$ vi hosts.yaml #update as mentioned above
$ ansible-playbook playbook-replicaset.yaml -i hosts.yaml
```

### Reference:

- https://registry.terraform.io/providers/hashicorp/aws/latest/docs
- https://docs.pritunl.com/docs/installation
- https://www.mongodb.com/cloud/atlas
- https://medium.com/setup-a-production-ready-mongodb-4-2-replica-set/setup-a-production-ready-mongodb-4-2-replica-set-with-ansible-2ba26b7bcf73
- https://docs.aws.amazon.com/quickstart/latest/mongodb/architecture.html

