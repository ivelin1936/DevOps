#!/bin/bash

echo "## Destroying the infrastructure build by Terraform..."
terraform destroy -auto-approve
