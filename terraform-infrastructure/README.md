# Azure Infrastructure Terraform Templates

> This approach focuses on `setting up the required infrastructure via Terraform`. It allows for source control of not only the solution code, connections, and setups `but also the infrastructure itself`.

<div align="center">
  <img src="https://github.com/user-attachments/assets/d16f2489-b7a6-4f62-9ca8-f137fcb8678c" alt="Centered Image" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/797e7981-6505-4cd9-839c-a107e43282d4" alt="Centered Image" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

## Prerequisites

- An `Azure subscription is required`. All other resources, including instructions for creating a Resource Group, are provided in this workshop.
- `Contributor role assigned or any custom role that allows`: access to manage all resources, and the ability to deploy resources within subscription.
- Please ensure that:
  - [Terraform is installed on your local machine](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli#install-terraform).
  - [Install the Azure CLI](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli) to work with both Terraform and Azure commands.

## Overview 

Templates structure:

```
.
├── README.md
├────── main.tf
├────── variables.tf
├────── provider.tf
├────── terraform.tfvars
├────── outputs.tf
```

- main.tf `(Main Terraform configuration file)`: This file contains the core infrastructure code. It defines the resources you want to create, such as virtual machines, networks, and storage. It's the primary file where you describe your infrastructure in a declarative manner.
- variables.tf `(Variable definitions)`: This file is used to define variables that can be used throughout your Terraform configuration. By using variables, you can make your configuration more flexible and reusable. For example, you can define variables for resource names, sizes, and other parameters that might change between environments.
- provider.tf `(Provider configurations)`: Providers are plugins that Terraform uses to interact with cloud providers, SaaS providers, and other APIs. This file specifies which providers (e.g., AWS, Azure, Google Cloud) you are using and any necessary configuration for them, such as authentication details.
- terraform.tfvars `(Variable values)`: This file contains the actual values for the variables defined in `variables.tf`. By separating variable definitions and values, you can easily switch between different sets of values for different environments (e.g., development, staging, production) without changing the main configuration files.
- outputs.tf `(Output values)`: This file defines the output values that Terraform should return after applying the configuration. Outputs are useful for displaying information about the resources created, such as IP addresses, resource IDs, and other important details. They can also be used as inputs for other Terraform configurations or scripts.

> KeyVault:

<div align="center">
  <img src="https://github.com/user-attachments/assets/a87ad7b6-9059-4679-934e-2ba1a3ea3bba" alt="Centered Image" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

<div align="center">
  <img src="https://github.com/user-attachments/assets/6f6b819e-6c71-43e7-83df-102055d38fb1" alt="Centered Image" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>

> Artifact Signing Account:

<div align="center">
  <img src="https://github.com/user-attachments/assets/8c302be2-7762-4496-8166-b3bea345fd48" alt="Artifact Signing account" style="border: 2px solid #4CAF50; border-radius: 5px; padding: 5px;"/>
</div>
  
## How to execute it 

```mermaid 
graph TD;
    A[az login] --> B(terraform init)
    B --> C{Terraform provisioning stage}
    C -->|Review| D[terraform plan]
    C -->|Order Now| E[terraform apply]
    C -->|Delete Resource if needed| F[terraform destroy]
```

!!! important
  Update `terraform.tfvars` with your information before running these commands.

### 1. Sign in to Azure

Change to the Terraform directory, then authenticate with the Azure CLI.

```sh
cd terraform-infrastructure
az login
```

<img width="550" alt="Terraform directory in terminal" src="https://github.com/user-attachments/assets/53b47aa7-134e-4cf7-b0b8-cdebdd0583ed" />

<img width="550" alt="Azure CLI authenticated" src="https://github.com/user-attachments/assets/1d9a247d-3dc9-472f-9305-4e4f0ecb72f1" />

### 2. Initialize Terraform

Download the required provider plugins and initialize the backend.

```sh
terraform init
```

<img width="550" alt="Terraform initialization completed" src="https://github.com/user-attachments/assets/a7a32891-ad72-423a-a1fe-bdb50925b546" />

### 3. Review the plan

Inspect the planned changes before provisioning resources.

```sh
terraform plan -var-file terraform.tfvars
```

<img width="550" alt="Terraform plan completed" src="https://github.com/user-attachments/assets/4741e863-1ccd-4f2a-a0b8-d5d1964bd890" />

### 4. Apply the configuration

Apply the reviewed changes. Terraform will prompt for confirmation.

```sh
terraform apply -var-file terraform.tfvars
```

<img width="550" alt="Terraform apply completed" src="https://github.com/user-attachments/assets/2b32b63f-3e9f-46da-a5e9-c39360135251" />

### 5. Remove resources when finished

Destroy the Terraform-managed resources when they are no longer required. Terraform will prompt for confirmation.

```sh
terraform destroy -var-file terraform.tfvars
```

<img width="550" alt="Terraform destroy completed" src="https://github.com/user-attachments/assets/f2089d03-3a3d-431d-b462-8148ef519104" />
