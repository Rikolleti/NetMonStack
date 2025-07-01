# 🚀 NetMonStack

NetMonStack — это production-like система мониторинга сетевых устройств с автоматическим сбором метрик, визуализацией,
алертами, резервным копированием конфигураций и CI/CD-деплоем.
Проект построен на стеке Zabbix + Grafana + Alertmanager + Ansible + Terraform + Docker Compose.

---

## 📌 Цель проекта

Создать полностью автоматизированную систему мониторинга и управления сетевой инфраструктурой,
демонстрирующую навыки DevOps, сетевого инжиниринга и SRE-подхода.

---

## 🧱 Архитектура

```

\[Сетевые устройства (Eltex, Huawei, Cisco)]
↓     SNMP
\[Zabbix Server] ←→ \[Zabbix DB]
↓
\[Zabbix Frontend (Web)]
↓
\[Grafana] ← Zabbix Data Source
↓
\[Alertmanager] ← Webhook от Zabbix
↓
Telegram / Email уведомления
↑
\[Ansible + cron] ← бэкапы + добавление хостов + шаблоны

```

---

## 📦 Компоненты проекта

| Компонент        | Назначение                                      |
|------------------|-------------------------------------------------|
| **Zabbix**        | Сбор метрик, триггеры, шаблоны                 |
| **Grafana**       | Визуализация через Zabbix Data Source          |
| **Alertmanager**  | Оповещения в Telegram / Email через webhook    |
| **Ansible**       | Загрузка шаблонов, добавление устройств, бэкапы|
| **Docker Compose**| Развёртывание всего стека                      |
| **GitHub Actions**| CI/CD: автодеплой и обновления                 |
| **Terraform**     | Развёртывание ВМ под мониторинг                |
| **cron**          | Ежедневный запуск бэкапов                      |

---

## 📁 Структура проекта

```

netmonstack/
├── docker-compose.yml
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
├── terraform/
│   └── main.tf
├── backups/
├── .github/
│   └── workflows/deploy.yml
├── TODO.md
└── README.md
```

---

## 📈 Возможности

- Мониторинг устройств по SNMP, ICMP, agent;
- Автоматическая визуализация данных в Grafana;
- Уведомления при проблемах (Telegram, Email);
- Загрузка шаблонов и добавление хостов через Ansible;
- Резервное копирование конфигураций по cron;
- Автодеплой через GitHub Actions;
- Развёртывание через Terraform за 1 минуту.

---

## ✅ To-Do (чек-лист реализации)

### 📦 Подготовка окружения

- [✅] Настроить Linux-сервер / облачную ВМ
- [✅] Установить Docker и Docker Compose
- [✅] Инициализировать репозиторий, структуру проекта

### 🐳 Мониторинг + Docker

- [ ] Написать `docker-compose.yml` для Zabbix, Grafana, Alertmanager
- [ ] Убедиться, что весь стек поднимается локально

### 🚀 CI/CD и GitHub Actions

- [ ] Создать workflow `.github/workflows/deploy.yml`
- [ ] Настроить автообновление проекта по push в main

### ⚙️ Ansible

- [ ] `import-templates.yml` — автоматический импорт SNMP-шаблонов
- [ ] `add-host.yml` — добавление устройств по IP/шаблону
- [ ] `backup-playbook.yml` — резервное копирование конфигураций
- [ ] `hosts.csv` — список устройств для массового импорта

### ⏱ Cron

- [ ] Настроить ежедневный запуск бэкапов через cron (например, 03:00)
- [ ] Проверить, что новые файлы появляются в `backups/`

### 📊 Grafana + Alertmanager

- [ ] Настроить provisioning Grafana (datasource + дашборды)
- [ ] Подключить webhook из Zabbix в Alertmanager
- [ ] Настроить Telegram / Email оповещения

### ☁️ Terraform

- [ ] Создать `main.tf` для создания ВМ
- [ ] Добавить outputs и SSH-доступ

### 🧼 Финализация

- [ ] Оформить README.md (архитектура, как запустить, описание)
- [ ] Сделать скриншоты Zabbix, Grafana
- [ ] Добавить проект в GitHub/резюме/LinkedIn

---

## 🔧 Как запустить (в разработке)

```bash
# 1. Клонируй репозиторий
git clone https://github.com/yourname/netmonstack.git
cd netmonstack

# 2. Запусти весь стек
docker-compose up -d

# 3. Выполни playbook для шаблонов
ansible-playbook ansible/import-templates.yml

# 4. Добавь хосты
ansible-playbook ansible/add-host.yml

# 5. Убедись, что всё работает и алерты приходят
````

---

## 🧠 Автор проекта

**Аждар Мамедов**, Network Engineer
📍 GitHub: \rikolleti
🔗 Telegram: \[@mamedov_ak]
🎯 Проект сделан в рамках обучения DevOps

---

## 📄 Лицензия

MIT — свободно использовать, дорабатывать и делиться.
