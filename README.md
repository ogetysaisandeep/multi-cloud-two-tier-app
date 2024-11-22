
# Multi-Cloud Two-Tier Application Deployment

This project demonstrates how to provision and deploy a two-tier application across AWS and Azure using Terraform. The setup involves:

1. **Frontend**: Hosted on a VM
    - AWS: EC2 Instance
    - Azure: Linux Virtual Machine
2. **Backend**: Hosted as a managed database
    - AWS: RDS MySQL
    - Azure: Azure SQL Database

This guide provides step-by-step instructions for students or developers to set up and deploy this infrastructure.

---

## Prerequisites

1. Install **Terraform**:
   - [Terraform Installation Guide](https://developer.hashicorp.com/terraform/tutorials)

2. Install **AWS CLI**:
   - [AWS CLI Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

3. Install **Azure CLI**:
   - [Azure CLI Installation Guide](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)

4. Ensure you have:
   - An AWS account and access keys.
   - An Azure account and subscription.

5. Configure your AWS CLI:
   ```bash
   aws configure
   ```
   Enter your AWS Access Key, Secret Key, Region, and Output format.

6. Authenticate your Azure CLI:
   ```bash
   az login
   ```

---

## Project Structure

The project is organized as follows:

```plaintext
multi-cloud-two-tier-app/
│
├── aws/
│   ├── main.tf            # Terraform for AWS resources
│   ├── variables.tf       # Variables for AWS
│   ├── outputs.tf         # Outputs for AWS
│   ├── terraform.tfvars   # AWS-specific variable values
│
├── azure/
│   ├── main.tf            # Terraform for Azure resources
│   ├── variables.tf       # Variables for Azure
│   ├── outputs.tf         # Outputs for Azure
│   ├── terraform.tfvars   # Azure-specific variable values
│
├── common/
│   ├── variables.tf       # Shared variables for both clouds
│
└── README.md              # This guide
```

---

## Step 1: Clone the Repository

Clone the project repository to your local machine:
```bash
git clone https://github.com/ogetysaisandeep/multi-cloud-two-tier-app.git
cd multi-cloud-two-tier-app
```

---

## Step 2: Configure AWS Infrastructure

1. Navigate to the AWS directory:
   ```bash
   cd aws
   ```

2. Review and modify the `terraform.tfvars` file with your AWS-specific values:
   ```hcl
   app_name    = "aws-two-tier-app"
   region      = "us-east-1"
   admin_user  = "awsadmin"
   admin_password = "Password123!"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration to provision the resources:
   ```bash
   terraform apply
   ```

6. Note the outputs:
   - Public IP of the frontend VM
   - RDS database endpoint

---

## Step 3: Configure Azure Infrastructure

1. Navigate to the Azure directory:
   ```bash
   cd ../azure
   ```

2. Review and modify the `terraform.tfvars` file with your Azure-specific values:
   ```hcl
   app_name      = "azure-two-tier-app"
   location      = "East US"
   admin_user    = "azureadmin"
   admin_password = "Password123!"
   ```

3. Initialize Terraform:
   ```bash
   terraform init
   ```

4. Plan the deployment:
   ```bash
   terraform plan
   ```

5. Apply the configuration to provision the resources:
   ```bash
   terraform apply
   ```

6. Note the outputs:
   - Public IP of the frontend VM
   - Azure SQL database connection string

---

## Step 4: Deploy Applications

1. SSH into the AWS EC2 instance:
   ```bash
   ssh -i <your-private-key.pem> ec2-user@<aws-frontend-ip>
   ```
   - Install and configure the application (e.g., Nginx, Node.js).

2. SSH into the Azure Linux VM:
   ```bash
   ssh azureadmin@<azure-frontend-ip>
   ```
   - Install and configure the application.

3. Update the application backend connection to use the respective database endpoint.

---

## Step 5: Verify Deployment

- Access the application via the public IPs of the frontend servers.
- Test connectivity to the backend databases.

---

## Cleanup

To avoid incurring costs, destroy the provisioned resources when done:

1. AWS:
   ```bash
   cd aws
   terraform destroy
   ```

2. Azure:
   ```bash
   cd ../azure
   terraform destroy
   ```

---

## Troubleshooting

1. **Terraform errors during `apply`**:
   - Verify your AWS and Azure credentials.
   - Ensure proper permissions for Terraform to create resources.

2. **Unable to SSH into VMs**:
   - Verify the security group/firewall rules allow SSH traffic.
   - Check your private key and VM login credentials.

3. **Database connection issues**:
   - Ensure the frontend VM can access the database endpoint.

---

This guide should help you provision and deploy the two-tier application seamlessly across AWS and Azure!
