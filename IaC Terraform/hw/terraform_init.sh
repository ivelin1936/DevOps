#!/bin/bash

echo "## Terraform setup up project (validate, init, plan, apply)"
terraform validate .
terraform init
terraform validate .
terraform plan
terraform apply -auto-approve
