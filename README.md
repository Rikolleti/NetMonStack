
# 🚀 NetMonStack

**NetMonStack** — это production-like система мониторинга сетевых устройств с автоматическим сбором метрик, визуализацией, алертами, резервным копированием конфигураций, деплоем через CI/CD и созданием образов через Packer.  
Проект построен на стеке **Zabbix + Grafana + Alertmanager + Ansible + Terraform + Packer + Docker Compose** и демонстрирует полный DevOps-цикл.

---

## 📌 Цель проекта

Создать полностью автоматизированную систему мониторинга и управления сетевой инфраструктурой, демонстрирующую навыки DevOps, сетевого инжиниринга и SRE-подхода: от создания образа до алертов и бэкапов.

---

## 🧱 Архитектура

```
        GitHub (CI/CD)
            │
            ▼
    ┌────────────────────┐
    │   Packer (Ubuntu)  │ ──► кастомный образ с Docker, Ansible, cron
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Terraform          │ ──► Создаёт ВМ из образа
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │ Docker Compose     │ ──► Запускает контейнеры:
    │                    │      Zabbix, Grafana, Alertmanager
    └────────────────────┘
            │
            ▼
    ┌────────────────────┐
    │                    |
    | Ansible (по ssh)   │ ──► Загружает шаблоны
    │                    | ──► Добавляет хосты
    │                    | ──► Делает бэкапы
    └────────────────────┘

            │
            ▼
    ┌────────────────────┐
    │ Grafana + Alerting │ ←── Визуализация и алерты
    └────────────────────┘


```

---

## 📦 Компоненты проекта

| Компонент         | Назначение                                        |
|-------------------|---------------------------------------------------|
| **Packer**         | Создание образа Ubuntu с Docker, Ansible, cron   |
| **Terraform**      | Развёртывание облачной ВМ на основе образа       |
| **Docker Compose** | Запуск мониторингового стека внутри ВМ           |
| **Zabbix**         | Сбор метрик, шаблоны, триггеры                   |
| **Grafana**        | Визуализация (через Zabbix Data Source)          |
| **Alertmanager**   | Отправка уведомлений (Telegram, Email)           |
| **Ansible**        | Импорт шаблонов, добавление хостов, бэкапы       |
| **GitHub Actions** | CI/CD: автоматическая сборка и деплой            |
| **cron**           | Ежедневный запуск бэкапов конфигураций           |

---

## 📁 Структура проекта

```

netmonstack/
├── packer/
│   ├── variables.pkrvars.hcl
│   ├── ubuntu-zabbix.pkr.hcl
│   └── scripts/
│       ├── install.sh
├── terraform/
│   └── main.tf
├── docker/
│   └── docker-compose.yml
│   └── .env
├── ansible/
│   ├── add-host.yml
│   ├── backup-playbook.yml
│   ├── import-templates.yml
│   ├── hosts.csv
│   └── group\_vars/
├── grafana/
│   └── provisioning/
├── alertmanager/
│   └── config.yml
├── zabbix/
│   └── snmp\_templates/
├── backups/
├── .github/
│   └── workflows/deploy.yml
├── README.md
└── TODO.md

````

---

## 📈 Возможности

- Мониторинг устройств по SNMP, ICMP, Zabbix Agent
- Визуализация метрик в Grafana (автоматически)
- Уведомления при сбоях в Telegram / Email
- Автоматическая загрузка шаблонов и добавление хостов
- Резервное копирование конфигураций раз в сутки по cron
- CI/CD-деплой при изменении кода (GitHub Actions)
- Развёртывание облачной ВМ за 1 минуту через Terraform
- Сборка кастомного образа через Packer

---

## ✅ To-Do (чек-лист реализации)

### 📦 Подготовка окружения

- [✅] Инициализировать репозиторий, структуру проекта
- [✅] Настроить базовые зависимости (Docker, Ansible и т.п.)

### 🔧 Packer

- [✅] Создать `ubuntu-zabbix.pkr.hcl`
- [✅] Написать `install.sh` (Docker, Ansible, cron)
- [✅] Собрать образ и протестировать

### ☁️ Terraform

- [ ] Написать `main.tf` с развёртыванием на основе образа
- [ ] Открыть порты, настроить SSH-доступ

### 🐳 Мониторинг + Docker

- [ ] Написать `docker-compose.yml` (Zabbix, Grafana, Alertmanager)
- [ ] Настроить .env и volumes
- [ ] Проверить запуск стека

### ⚙️ Ansible

- [ ] `import-templates.yml` — импорт шаблонов
- [ ] `add-host.yml` — массовое добавление устройств
- [ ] `backup-playbook.yml` — бэкап конфигураций
- [ ] `hosts.csv` — инвентарь устройств

### ⏱ Cron

- [ ] Настроить `cron` для ежедневных бэкапов
- [ ] Проверить, что файлы появляются в `backups/`

### 📊 Grafana + Alertmanager

- [ ] Provisioning dashboards
- [ ] Настроить Alertmanager webhook
- [ ] Подключить Telegram / Email

### 🚀 CI/CD (GitHub Actions)

- [ ] Написать `.github/workflows/deploy.yml`
- [ ] Добавить шаги: Packer → Terraform → Docker → Ansible
- [ ] Добавить lint-проверки и уведомления

### 🧼 Финализация

- [ ] Оформить README.md, архитектуру, инструкции
- [ ] Добавить скриншоты Zabbix и Grafana
- [ ] Выложить на GitHub, добавить в резюме

---

## 🔧 Как запустить (в разработке)

```bash
# 1. Клонируй репозиторий
git clone https://github.com/yourname/netmonstack.git
cd netmonstack

# 2. Собери образ
cd packer && packer build ubuntu-zabbix.pkr.hcl

# 3. Разверни инфраструктуру
cd terraform && terraform apply

# 4. Подключись к ВМ и запусти стек мониторинга
ssh user@VM_IP
cd docker && docker-compose up -d

# 5. Настрой Zabbix: шаблоны и хосты
ansible-playbook ansible/import-templates.yml
ansible-playbook ansible/add-host.yml
````

---

## 🧠 Автор проекта

**Аждар Мамедов**, Network Engineer
📍 GitHub: [@rikolleti](https://github.com/rikolleti)
🔗 Telegram: [@mamedov\_ak](https://t.me/mamedov_ak)
🎯 Проект реализуется в рамках подготовки к роли DevOps/SRE

---

## 📄 Лицензия

MIT — свободно использовать, дорабатывать и распространять.
