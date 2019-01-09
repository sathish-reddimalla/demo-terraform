# demo-terraform
Terraform script to spin AWS ECS infra
Because of some security concens I'm building the Jenkins job without variable file here on the repo and it would be on my Jenkins master machine.
The above scripts will give you the VPC, Subnets, Routing Table, Security Group, Autoscaling Group, Load balancer, AWS ECS cluster with Task defination and service.
To run the terraform script change the variable file accounding to you needs.
You can use this script for any environment by changing the variables file.
