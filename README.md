![](https://img.shields.io/github/issues/michalswi/azure-vm-behind-lb)
![](https://img.shields.io/github/forks/michalswi/azure-vm-behind-lb)
![](https://img.shields.io/github/stars/michalswi/azure-vm-behind-lb)
![](https://img.shields.io/github/last-commit/michalswi/azure-vm-behind-lb)

Adjust values [here](./variables.tf) if needed for:
- **VM size**, by default it's `Standard_B1s`
- **Azure region**, by default it's `West Europe`
- **Public IP**, your public IP address allowed to ssh to VM

**whatismyip** GitHub [link](https://github.com/michalswi/whatismyip).

```
# Log in to Azure

az login


# Generate ssh key

ssh-keygen -t rsa -b 2048 -N "" -f ./demo -C "demo@demon"


# Deploy Azure LB and VM

PUB_IP=<your_public_facing_ip>
terraform init
terraform apply -var public_ip=$PUB_IP


# Verify ports

$ sudo nmap -v -Pn -p 22,80,443 <LB_public_IP>
(...)
PORT    STATE  SERVICE
22/tcp  open   ssh
80/tcp  closed http
443/tcp closed https


# Register your public IP 

$ NAME=demo-$RANDOM
$ ./fqdn.sh <LB_public_IP> $NAME
<$NAME>.westeurope.cloudapp.azure.com


# Configure docker on VM

$ ssh -i <priv_key> -l demo <LB_public_IP>
demo@demon:~$ sudo usermod -aG docker $(whoami)
demo@demon:~$ exit        // log out from VM and log in

$ ssh -i <priv_key> -l demo <LB_public_IP>
demo@demon:~$ docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES


# Run whatismyip app

demo@demon:~$ git clone https://github.com/michalswi/whatismyip.git
demo@demon:~$ cd whatismyip

demo@demon:~$ SERVER_PORT=80 make docker-run-bridge


# Test (only HTTP no HTTPS)

$ sudo nmap -v -Pn -p 22,80 <LB_public_IP>
(...)
PORT   STATE SERVICE
22/tcp open  ssh
80/tcp open  http

curl $NAME.westeurope.cloudapp.azure.com
curl $NAME.westeurope.cloudapp.azure.com/ip

OR

firefox $NAME.westeurope.cloudapp.azure.com
firefox $NAME.westeurope.cloudapp.azure.com/ip


# Destroy Azure resources

terraform destroy -auto-approve -var public_ip=$PUB_IP
./clear.sh
```