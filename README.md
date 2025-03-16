# GCP Storage Bucket and VPC Assignment

## 📌 Overview

This repository contains Terraform configurations for deploying a **Google Cloud Storage Bucket** and a **VPC network** in Google Cloud Platform (GCP). It automates infrastructure provisioning using Terraform.

## 🛠 Prerequisites

Before you begin, ensure you have the following installed:

- **Terraform** (Download from [terraform.io](https://developer.hashicorp.com/terraform/downloads))
- **Google Cloud SDK** (Install via [cloud.google.com/sdk](https://cloud.google.com/sdk/docs/install))
- **Git** (Check with `git --version`)
- **A Google Cloud Account** with a project set up

## 📂 Repository Structure

```
📦 gcp-storage-bucket-assignment
├── storage-bucket/         # Contains files uploaded to Cloud Storage
│   ├── beach.jpg           # Sample image file
│   ├── coffee.jpg          # Sample image file
│   ├── index.html          # HTML file referencing images
├── main.tf                 # Terraform configuration file
├── variables.tf            # Defines Terraform variables
├── outputs.tf              # Stores Terraform output values
├── README.md               # Documentation (this file)
```

## 🏗 Terraform Resources Included

The `main.tf` file provisions the following resources in Google Cloud:

1️⃣ **Google Cloud Storage Bucket** (`gcp-tf-storage-bucket-tiqs`)

- Stores uploaded images (`beach.jpg`, `coffee.jpg`) and `index.html`.
- Configured with public access permissions for the uploaded files.

2️⃣ **Google Compute Network** (`auto-vpc-tf`)

- A Virtual Private Cloud (VPC) network.
- Created with `auto_create_subnetworks = false` for manual subnet creation.

3️⃣ **Google Compute Subnetwork** (`sub-sg`)

- Subnet in the `us-west1` region with CIDR `10.231.1.0/24`.
- Connected to `auto-vpc-tf`.

4️⃣ **Google Storage Bucket Object**

- Uploads the following files to the storage bucket:
  - `beach.jpg`
  - `coffee.jpg`
  - `index.html`
- Configured with `READER` ACL to make them publicly accessible.

## 🚀 Deployment Steps

### 1️⃣ **Clone the Repository**

```sh
git clone https://github.com/tiqsclass6/gcp-storage-bucket-assignment.git
cd gcp-storage-bucket-assignment
```

### 2️⃣ **Set Up Google Cloud Authentication**

Ensure your service account JSON key is available and authenticate Terraform:

```sh
export GOOGLE_APPLICATION_CREDENTIALS="path/to/service-account.json"
```

### 3️⃣ **Initialize Terraform**

```sh
terraform init
```

This downloads the necessary Terraform provider plugins.

### 4️⃣ **Plan and Apply the Terraform Configuration**

```sh
terraform plan
terraform apply -auto-approve
```

Terraform will create:

- A **Cloud Storage Bucket** (`gcp-tf-storage-bucket-tiqs`)
- A **VPC Network** (`auto-vpc-tf`)
- A **Subnet** (`sub-sg`)
- **Uploaded files** (`beach.jpg`, `coffee.jpg`, `index.html`)

### 5️⃣ **Verify Resources in Google Cloud**

- **Storage Bucket:** [Google Cloud Storage Console](https://console.cloud.google.com/storage/browser)
- **VPC Network:** [VPC Networks](https://console.cloud.google.com/networking/networks)
- **List Storage Objects:**

  ```sh
  gcloud storage ls gs://gcp-tf-storage-bucket-tiqs
  ```

- **Access Public Files:**

  ```
  https://storage.googleapis.com/gcp-tf-storage-bucket-tiqs/beach.jpg
  https://storage.googleapis.com/gcp-tf-storage-bucket-tiqs/coffee.jpg
  https://storage.googleapis.com/gcp-tf-storage-bucket-tiqs/index.html
  ```

### 6️⃣ **Destroy Resources (Optional)**

To clean up and remove all provisioned resources:

```sh
terraform destroy -auto-approve
```

## 🛠 Troubleshooting

- **Permission Errors:** Ensure your service account has the required roles (`Storage Admin`, `Compute Admin`).
- **Terraform Lock Issues:** Run `rm -f .git/index.lock` if a Git process is stuck.
- **Merge Conflicts:** Use `git pull origin main --allow-unrelated-histories` if history is unrelated.

## 🤝 Contributing

Feel free to open a **pull request** if you'd like to improve this repository!
