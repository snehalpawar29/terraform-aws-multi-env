# ☁️ Terraform AWS Multi-Environment Infrastructure

![Terraform](https://img.shields.io/badge/Terraform-IaC-7B42BC?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazonaws&logoColor=white)
![EC2](https://img.shields.io/badge/Amazon-EC2-FF9900?logo=amazonaws&logoColor=white)
![S3](https://img.shields.io/badge/Amazon-S3-569A31?logo=amazons3&logoColor=white)
![DynamoDB](https://img.shields.io/badge/Amazon-DynamoDB-4053D6?logo=amazondynamodb&logoColor=white)

> AWS infrastructure managed with **Terraform Modules and Workspaces**, using a single codebase to create different resource configurations for development and production environments.

---

## 📌 Project Overview

This project demonstrates how **Terraform Workspaces and reusable Modules** can be used to manage multiple AWS environments from the same Terraform codebase.

The project currently defines two environments:

- 🧪 **dev**
- 🚀 **prod**

Each workspace uses the same Terraform modules but creates a different number of AWS resources according to the workspace configuration.

---

## 🎯 Project Objectives

- Understand Terraform Workspaces
- Practice reusable Terraform Modules
- Manage multiple environments from one codebase
- Configure environment-specific resource counts
- Provision AWS infrastructure using Infrastructure as Code
- Use Terraform variables, locals, modules, and outputs
- Practice Terraform lifecycle operations such as `plan`, `apply`, and `destroy`

---

## 🏗️ Architecture

### Environment Configuration

| Resource | Dev | Prod |
|---|---:|---:|
| EC2 Instances | 2 | 3 |
| S3 Buckets | 1 | 2 |
| DynamoDB Tables | 1 | 2 |

The resource counts are controlled through a workspace-based configuration map.

```text
                    Terraform Codebase
                           │
                           ▼
                    Terraform Workspace
                     ┌─────┴─────┐
                     │           │
                    dev         prod
                     │           │
              ┌──────┼──────┐ ┌──┼──────────┐
              ▼      ▼      ▼ ▼  ▼          ▼
             EC2    S3   DynamoDB  EC2      S3
              2      1      1       3        2
                                      │
                                      ▼
                                  DynamoDB
                                      2
````

---

## 🧩 Terraform Modules

The infrastructure is divided into reusable modules:

```text
modules/
├── ec2/
├── s3/
└── dynamodb/
```

### EC2 Module

Responsible for:

* EC2 instances
* EC2 key pair
* Security group

### S3 Module

Responsible for:

* S3 buckets
* Public access block configuration

### DynamoDB Module

Responsible for:

* DynamoDB tables
* `PAY_PER_REQUEST` billing mode

---

## 🔄 Workspace-Based Configuration

The project uses a `locals` map to define the resource configuration for each workspace.

```hcl
locals {
  env_config = {
    dev  = {
      instance_count = 2
      bucket_count   = 1
      table_count    = 1
    }

    prod = {
      instance_count = 3
      bucket_count   = 2
      table_count    = 2
    }
  }

  current = lookup(
    local.env_config,
    terraform.workspace,
    local.env_config["dev"]
  )
}
```

The selected workspace determines how many resources are created.

For example:

```text
terraform.workspace = dev
        │
        ▼
instance_count = 2
bucket_count   = 1
table_count    = 1
```

Switching to:

```text
terraform.workspace = prod
```

results in:

```text
instance_count = 3
bucket_count   = 2
table_count    = 2
```

This allows the same Terraform configuration to manage different environment sizes.

---

## 📂 Project Structure

```text
.
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── terraform.tf
├── terra-automate-key.pub
│
└── modules/
    ├── ec2/
    │   ├── ...
    │   └── ...
    │
    ├── s3/
    │   ├── ...
    │   └── ...
    │
    └── dynamodb/
        ├── ...
        └── ...
```

### Root Configuration

| File           | Purpose                                  |
| -------------- | ---------------------------------------- |
| `main.tf`      | Workspace configuration and module calls |
| `variables.tf` | Root variables                           |
| `outputs.tf`   | Module outputs                           |
| `providers.tf` | AWS provider configuration               |
| `terraform.tf` | Terraform and provider requirements      |

---

## 🛠️ Prerequisites

Before using the project, install/configure:

* Terraform `>= 1.5.0`
* AWS CLI
* AWS credentials
* SSH public key

Configure AWS credentials:

```bash
aws configure
```

---

# 🚀 Deployment

## 1. Initialize Terraform

```bash
terraform init
```

---

## 2. Create the Dev Workspace

```bash
terraform workspace new dev
```

Review the execution plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

---

## 3. Create the Prod Workspace

Create the production workspace:

```bash
terraform workspace new prod
```

Review the plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

---

## 🔄 Switching Between Workspaces

List available workspaces:

```bash
terraform workspace list
```

Switch to development:

```bash
terraform workspace select dev
```

Switch to production:

```bash
terraform workspace select prod
```

View outputs:

```bash
terraform output
```

---

## 🗑️ Destroy Infrastructure

To destroy the infrastructure belonging to the currently selected workspace:

```bash
terraform destroy
```

To destroy both environments:

```bash
terraform workspace select dev
terraform destroy -auto-approve

terraform workspace select prod
terraform destroy -auto-approve
```

> ⚠️ Always verify the active workspace before running `terraform destroy`.

---

# ☁️ AWS Infrastructure Details

The project currently uses the following AWS resources:

### Amazon EC2

* Dev: 2 instances
* Prod: 3 instances
* Instance type: `t3.micro`
* Root volume: 10 GB gp3

### Amazon S3

* Dev: 1 bucket
* Prod: 2 buckets
* Public access block enabled

### Amazon DynamoDB

* Dev: 1 table
* Prod: 2 tables
* Billing mode: `PAY_PER_REQUEST`

---

## 🔐 EC2 Security Group

The EC2 module configures inbound access for:

| Port | Protocol | Purpose |
| ---: | -------- | ------- |
|   22 | TCP      | SSH     |
|   80 | TCP      | HTTP    |

Outbound traffic is allowed.

---

## 🏷️ Workspace-Based Resource Naming

Resources are prefixed with the active workspace name to help distinguish environments.

Examples:

```text
dev-terra-server-1
dev-terra-server-2

prod-terra-server-1
prod-terra-server-2
prod-terra-server-3
```

This helps prevent naming conflicts between environments.

---

# 🧠 Key Terraform Concepts Practiced

### Terraform Workspaces

Used to maintain separate Terraform states for different environments while using the same configuration.

### Terraform Modules

Used to organize infrastructure into reusable components:

```text
EC2 Module
S3 Module
DynamoDB Module
```

### Local Values

Used to define environment-specific resource configuration.

### Resource `count`

Used to create different numbers of resources based on the active workspace.

### Terraform Outputs

Used to expose values returned by the infrastructure modules.

---

# 📚 Key Learnings

Through this project, I practiced:

* Infrastructure as Code using Terraform
* Terraform Workspaces
* Terraform Modules
* AWS resource provisioning
* Environment-specific configurations
* Terraform variables and locals
* Terraform outputs
* Resource `count`
* AWS EC2 configuration
* Amazon S3 configuration
* DynamoDB provisioning
* Terraform state management
* Infrastructure lifecycle management

---

# 🔮 Future Improvements

Potential improvements for this project include:

* Add a dedicated `staging` environment
* Add remote Terraform state using S3
* Add state locking
* Add CI/CD with GitHub Actions or Jenkins
* Add environment-specific variable files
* Add VPC and subnet modules
* Add IAM modules
* Add automated validation and security scanning

---

# 👨‍💻 Author

## Snehal Pawar

**Aspiring DevOps Engineer**

AWS | Terraform | Docker | Kubernetes | Jenkins | Linux | CI/CD

* GitHub: [snehalpawar29](https://github.com/snehalpawar29)
* LinkedIn: [Snehal Pawar](https://www.linkedin.com/in/snehalpawar29/)
* Portfolio: [DevOps Portfolio](https://snehalpawar29.github.io/Snehal-Pawar-Devops-Portfolio/)

---

<p align="center">

### 🚀 Infrastructure as Code • Automate • Learn • Improve

</p>
