# 🏠 Proxmox Home Lab Automation with OpenTofu

[![OpenTofu](https://img.shields.io/badge/OpenTofu-v1.10.7-663399?logo=opentofu&logoColor=white)](https://opentofu.org/)
[![Proxmox](https://img.shields.io/badge/Proxmox-VE-orange?logo=proxmox&logoColor=white)](https://www.proxmox.com/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An automated Infrastructure-as-Code (IaC) repository for managing a Proxmox Home Lab. This project uses **OpenTofu** (a fork of Terraform) and the **bpg/proxmox** provider to provision and manage Virtual Machines and LXC Containers through a clean, modular architecture.

---

## 🚀 Key Features

- **Modular Design**: Separated modules for VMs and LXC containers for high reusability.
- **Self-Contained Resources**: Individual `.tf` files per resource, allowing independent management of credentials and templates.
- **Cloud-Init Integration**: Fully automated VM provisioning including SSH key injection, user creation, and network configuration.
- **Security-First**: Sensitive information is handled via gitignored `terraform.tfvars`.
- **Infrastructure Inventory**: Integrated `AGENTS.md` to map and document your lab topology.

---

## 📁 Project Structure

```text
.
├── main.tf                 # Primary entry point (calls sub-modules)
├── provider.tf             # Proxmox provider configuration
├── variables.tf            # Global connection & network variables
├── terraform.tfvars        # [SECRET] Local credentials (gitignored)
│
├── vms/                    # 🖥️ Virtual Machine definitions
│   ├── outputs.tf          # VM module outputs
│   └── variables.tf        # VM module variables
│
├── containers/             # 📦 LXC Container definitions
│   ├── outputs.tf          # Container module outputs
│   └── variables.tf        # Container module variables
│
└── modules/                # 🔧 Core base modules
    ├── vm/                 # Proxmox VM resource wrapper
    └── lxc/                # Proxmox LXC resource wrapper
```

---

## 🛠️ Prerequisites

1.  **OpenTofu**: Install via Homebrew (macOS) or your preferred package manager.
    ```bash
    brew install opentofu
    ```
2.  **Proxmox Template**: A VM template (ID 9001 recommended) with `cloud-init` and `qemu-guest-agent` installed.
3.  **LXC Template**: A Debian 12 standard template downloaded in your Proxmox storage (`local`).

---

## ⚙️ Getting Started

### 1. Initialize Configuration
Copy the example configuration file and fill in your Proxmox credentials:

```bash
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` with your endpoint, username, and password.

### 2. Prepare Modules
Initialize the OpenTofu workspace and download necessary providers:

```bash
tofu init
```

---

## 📝 Usage

### Creating a New Resource
Templates are provided in the `vms/` and `containers/` directories.

1.  **For a VM**:
    ```bash
    cp vms/vm_example.tf.example vms/my_new_vm.tf
    ```
2.  **For a Container**:
    ```bash
    cp containers/ct_example.tf.example containers/my_new_ct.tf
    ```
3.  Edit the file to set your desired `vmid`, `hostname`, `ip_address`, and `password`.

### Deployment
Always run a plan before applying changes to ensure everything is correct:

```bash
# Preview changes
tofu plan

# Deploy infrastructure
tofu apply
```

### Destruction
To remove a specific resource without affecting others:
```bash
tofu destroy -target='module.containers.module.my_new_ct'
```

---

## 🛡️ Security & Privacy
This repository is designed to be public-ready:
- `terraform.tfvars` is gitignored to prevent credential leaks.
- `AGENTS.md` is gitignored to hide internal network topology.
- Example files (`*.example`) are used for shared templates.

---

## 📜 License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

Developed with ❤️ by **Donni Triosa**.
