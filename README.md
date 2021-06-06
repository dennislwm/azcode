# azcode
Terraform starter project for Azure Cloud ["AZ"].

<!-- TOC -->

- [azcode](#azcode)
  - [About azcode](#about-azcode)
  - [Project Structure](#project-structure)
  - [Installation](#installation)
    - [Terraform](#terraform)
    - [AZ CLI](#az-cli)
      - [Installation](#installation)
      - [Authentication](#authentication)
      - [Troubleshooting](#troubleshooting)

<!-- /TOC -->

---
## About azcode
**azcode** was a personal project to:
- automate setting up remote state in cloud storage
- automate SSH key generation and uploading to cloud server
- automate vm creation in a cloud server
- automate package installation in a cloud server
- automate make swapfile in a cloud server
- automate docker-compose in a cloud server
- automate restore files to a cloud server
- automate backup files from a cloud server

---
## Project Structure
     azcode/                          <-- Root of your project
       |- README.md                   <-- This README markdown file
       +- tf/                         <-- Terraform root folder
          +- 001/                     <-- Minimal Terraform project
             |- main.tf               <-- Main TF file (required)
          +- 002/                     <-- Store a TF state file in AZ storage (depends on 001)
          +- 003/                     <-- Create a virtual network (depends on 001)
          +- 004/                     <-- Create a network security group (depends on 001)
          +- 005/                     <-- Create a virtual machine (no dependency)
          +- 006/                     <-- Create a managed app service (no dependency)
          +- 007/                     <-- Create a managed MySql Database (no dependency)

---
## Installation

### Terraform

* [Download Terraform 0.14.9](https://releases.hashicorp.com/terraform)

Terraform is distributed as a single binary. Install Terraform (64-bit) by unzipping it and moving it to a directory included in your system's ```PATH```.

### AZ CLI

#### Installation

* [Install the Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

Run the command.

```
$ az login
```

#### Authentication

Terraform supports a few different methods for AZ authentication:

* The simplest and quickest method is to use the AZ CLI. Not really a problem for single-admin shops (the lab uses this method).

*Note: A Terraform state file residing in AZ storage accounts is considered as stored locally. This is because accessing the state file requires the user account that was used to log in.*

* The best practice for Terraform authentication is to use a Service Principal.

* Managed Service Identities are another way for Terraform to authenticate with AZ.

#### Troubleshooting

**Adding Azure CLI to Your PATH**

If the ```az``` command doesn't work, check your ```PATH``` to verify whether or not the Azure CLI installation path is listed.

```
C:\Program Files (x86)\Microsoft SDKs\Azure\CLI2\wbin
```
