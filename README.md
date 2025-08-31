
# 🚀 NetMonStack

NetMonStack is a production-like monitoring system for network devices with automated metric collection, visualization, alerts, configuration backups, CI/CD deployment, and Packer-based image creation.
The project is built on the Zabbix + Grafana + Ansible + Terraform + Packer + Docker Compose stack and demonstrates the full DevOps lifecycle.

---

## 📌 Project Goal

To build a fully automated system for monitoring and managing network infrastructure that showcases DevOps, network engineering, and SRE practices — from image creation to alerts and backups.

---

## 🧱 Architecture

```

        GitHub (CI/CD)
            │
            ▼
    ┌────────────────────┐
    │   Packer (Ubuntu)  │ ──► custom image with Docker, Ansible, cron
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Terraform          │ ──► Creates VM from the image
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Docker Compose     │ ──► Runs containers:
    │                    │      Zabbix, Grafana, Alertmanager
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Ansible (via SSH)  │ ──► Imports templates
    │                    │ ──► Adds hosts
    │                    │ ──► Performs backups
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Grafana + Zabbix   │ <── Visualization and alerts
    └────────────────────┘

```

---

## 📦 Project Components

| Component          | Purpose                                        |
| ------------------ | ---------------------------------------------- |
| **Packer**         | Build Ubuntu image with Docker, Ansible, cron  |
| **Terraform**      | Deploy VM in the cloud using the image         |
| **Docker Compose** | Run monitoring stack inside the VM             |
| **Zabbix**         | Metric collection, templates, triggers, alerts |
| **Grafana**        | Visualization (via Zabbix Data Source)         |
| **Ansible**        | Import templates, add hosts, backups           |
| **GitHub Actions** | CI/CD: automated build and deployment          |
| **cron**           | Daily configuration backup tasks               |

---

## 📁 Project Structure

```

netmonstack/
├── packer/
│   ├── variables.pkrvars.hcl
│   ├── ubuntu-zabbix.pkr.hcl
│   └── scripts/
│       ├── install.sh
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   ├── outputs.tf
│   └── providers.tf
├── docker/
│   └── docker-compose.yml
│   └── .env
├── ansible/
│   │   └── prod/
│   │       ├── hosts.ini
│   │       ├── hosts.yml
│   │       ├── hosts.csv
│   │       └── group_vars/
│   │           ├── all.yml
│   │           └── zabbix_api.yml
├── grafana/
│   └── provisioning/
|──zabbix/
|   ── server/
│   ├── alertscripts/         # Notification scripts (Telegram, etc.)
│   ├── export/               # Template exports
│   ├── externalscripts/      # External monitoring scripts
│   └── snmptraps/            # SNMP trap files
|   ── snmp_templates/        # SNMP monitoring templates
├── backups/
├── .github/
│   └── workflows/deploy.yml
├── README.md
└── TODO.md

````

---

## 📈 Features

- 🔍 Device monitoring (SNMP, Zabbix Agent, ICMP)
- 📊 Grafana visualization (dashboards, alerts via Zabbix triggers)
- 📩 Failure notifications (Telegram, Email via Zabbix Media Types)
- ⚙️ Automated Zabbix template import
- 🧩 Bulk device import via Ansible
- 🗄 Configuration backups via cron
- 🚀 CI/CD deployment with GitHub Actions
- 🏗 Fast infrastructure provisioning with Terraform
- 🧱 Custom image building with Packer

---

## ✅ To-Do (Implementation Checklist)

### 📦 Environment Setup

- [✅] Initialize repository and project structure
- [✅] Set up base dependencies (Docker, Ansible, etc.)

### 🔧 Packer

- [✅] Create `ubuntu-zabbix.pkr.hcl`
- [✅] Write `install.sh` (Docker, Ansible, cron)
- [✅] Build and test the image

### ☁️ Terraform

- [✅] Write `main.tf` for VM deployment
- [✅] Configure firewall ports and SSH access

### 🐳 Monitoring + Docker

- [✅] `docker-compose.yml` with Zabbix, Grafana, PostgreSQL
- [✅] Create `.env.example` file
- [✅] Test stack and configure volumes

### ⚙️ Ansible

- [✅] Separate group_vars (all.yml, zabbix_api.yml)
- [✅] playbooks/prod/import-templates.yml
- [✅] playbooks/prod/add-host.yml (CSV → Zabbix API)
- [✅] playbooks/prod/backup-playbook.yml (role: net-backup)
- [✅] ansible/inventory/prod/hosts.csv

### ⏱ Cron

- [ ] Configure `cron` for daily backups
- [ ] Verify files appear in `backups/`

### 📊 Grafana + Zabbix

- [ ] Provisioning dashboards
- [ ] Configure Zabbix Data Source
- [ ] Set up notifications (Telegram, Email)

### 🚀 CI/CD (GitHub Actions)

- [ ] Write `.github/workflows/deploy.yml`
- [ ] Add steps: Packer → Terraform → Docker → Ansible
- [ ] Add lint checks and notifications

### 🧼 Finalization

- [ ] Polish README.md, architecture docs, instructions
- [ ] Add screenshots of Zabbix and Grafana
- [ ] Publish on GitHub and include in resume

---

## 🔧 How to Run (WIP)

```bash
# 1. Clone the repo
git clone https://github.com/yourname/netmonstack.git
cd netmonstack

# 2. Build the image
cp docker/.env.example docker/.env
cd packer && packer build -var-file=variables.pkrvars.hcl ubuntu-zabbix.pkr.hcl

# 3. Deploy infrastructure
cd ../terraform
terraform init
terraform apply

# 4. Connect to VM and start monitoring stack
ssh user@VM_IP
cd docker && docker-compose up -d

# 5. Configure Zabbix: templates and hosts
# import templates
ansible-playbook -i ansible/inventory/prod playbooks/prod/import-templates.yml
# add hosts from CSV (zabbix_api group)
ansible-playbook -i ansible/inventory/prod playbooks/prod/add-host.yml
# backup device configs
ansible-playbook -i ansible/inventory/prod playbooks/prod/backup-playbook.yml
````

---

## 🧠 Author

**Azhdar Mamedov**, Network Engineer
📍 GitHub: [@rikolleti](https://github.com/rikolleti)
🔗 Telegram: [@mamedov\_ak](https://t.me/mamedov_ak)
🎯 Project developed as part of preparation for a DevOps/SRE role

---

## 📄 License

MIT — free to use, modify, and distribute.
