
'
#Objectives

Create custom mode VPC networks with firewall rules
Create VM instances using Compute Engine
Explore the connectivity for VM instances across VPC networks
Create a VM instance with multiple network interfaces

'

gcloud auth list
gcloud config list project
#Create custom mode VPC networks with firewall rules
gcloud compute networks create managementnet --project=qwiklabs-gcp-00-fcebd6eb0827 --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional
gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-00-fcebd6eb0827 --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-east1

#Create the privatenet network
gcloud compute networks create privatenet --subnet-mode=custom
gcloud compute networks subnets create privatesubnet-us --network=privatenet --region=us-east1 --range=172.16.0.0/24

gcloud compute networks subnets create privatesubnet-eu --network=privatenet --region=europe-west1 --range=172.20.0.0/20

gcloud compute networks list

gcloud compute networks subnets list --sort-by=NETWORK
#Create the firewall rules for managementnet


#Create the firewall rules for privatenet
gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
gcloud compute firewall-rules create privatenet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=privatenet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

gcloud compute firewall-rules list --sort-by=NETWORK

#Create VM instances

#Create the managementnet-us-vm instance

#Create the privatenet-us-vm instance
gcloud compute instances create managementnet-us-vm --zone="us-east1-b" --machine-type=e2-micro --subnet=managementsubnet-us
gcloud compute instances create privatenet-us-vm --zone="us-east1-b" --machine-type=e2-micro --subnet=privatesubnet-us
gcloud compute instances create privatenet-us-vm --zone="" --machine-type=e2-micro --subnet=privatesubnet-us

gcloud compute instances list --sort-by=ZONE

#Explore the connectivity between VM instances

ping -c 3 <Enter mynet-eu-vm's external IP here>

ping -c 3 <Enter managementnet-us-vm's external IP here>

ping -c 3 <Enter privatenet-us-vm's external IP here>

ping -c 3 <Enter mynet-eu-vm's internal IP here>

ping -c 3 <Enter managementnet-us-vm's internal IP here>

ping -c 3 <Enter privatenet-us-vm's internal IP here>

#Create a VM instance with multiple network interfaces

Create the VM instance with multiple network interfaces

sudo ifconfig

#SSH terminal for vm-appliance.
ping -c 3 <Enter privatenet-us-vm's internal IP here>

ping -c 3 privatenet-us-vm
ping -c 3 <Enter managementnet-us-vm's internal IP here>

ping -c 3 <Enter mynet-us-vm's internal IP here>

ping -c 3 <Enter mynet-eu-vm's internal IP here>

#To list the routes for vm-appliance instance, run the following command:

ip route


