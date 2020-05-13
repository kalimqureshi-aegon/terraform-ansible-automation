# terraform-ansible-automation
Terraform project common module implemented. Common module for creation of a Subnet in existing VPC and EC2 machine in newly created subnet

Ansible playbook main.yml will be used to execute existing terraform project and existing plan based on Inventories kept in Inventories folder

Existing plan are kept at terraform-ansible-automation/terraform-scripts/create-subnet-ec2-plan/plan_output.txt. 

    ansible-playbook -i Inventories/dt/inventory-apply-existing-plan main.yml

Create new plan and execute it from a terraform project

    ansible-playbook -i Inventories/dt/inventory-create-exec-plan main.yml
