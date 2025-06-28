# Unraid Ansible Project Checklist

![Homelab](https://img.shields.io/badge/Homelab-FF5733?style=for-the-badge&logo=homeassistant&logoColor=white) ![Unraid](https://img.shields.io/badge/Unraid-F05A28?style=for-the-badge&logo=unraid&logoColor=white) ![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white) ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) ![Media Server](https://img.shields.io/badge/Media%20Server-000000?style=for-the-badge&logo=plex&logoColor=white) ![Security](https://img.shields.io/badge/Security-000000?style=for-the-badge&logo=dependabot&logoColor=white) ![Automation](https://img.shields.io/badge/Automation-0078D4?style=for-the-badge&logo=azure-pipelines&logoColor=white) ![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-2671E5?style=for-the-badge&logo=githubactions&logoColor=white)

A comprehensive Ansible playbook for automating the deployment and management of a robust homelab environment on Unraid.

## Unraid Homelab Ansible Automation

Ansible playbooks for deploying and managing a homelab environment on Unraid, including media services, security, and web infrastructure.

## High Priority Tasks
- [ ] **Crowdsec (Threat Detection) deployed**
- [ ] **Build Home Assistant VM into Ansible**

## Setup & Core Infrastructure
- [x] Common infrastructure setup (Python venv, Docker check, appdata dir, web network)
- [x] Database services deployed (PostgreSQL, Redis)
  - [ ] Ensure "Wait for Redis to be ready" task is uncommented/reviewed in `ansible/roles/database/tasks/main.yml`
- [x] Ansible Runner setup (Docker SDK)

## Web & Network Services
- [x] Traefik reverse proxy deployed and configured
- [x] DuckDNS for dynamic DNS updates
- [ ] Pi-hole DNS server deployed and configured (currently commented out in `ansible/roles/web/tasks/main.yml`)
- [ ] SSL certificates & internal dns resolution to setup block list better (SSL tasks commented out in `ansible/roles/web/tasks/main.yml`)
- [ ] Overseerr (requests) Traefik integration enabled (labels commented out in `ansible/roles/web/tasks/main.yml`)
- [ ] Auto pull domain names from Ansible job 

## Security Layer
- [x] Authentik (Identity Provider) deployed (server and worker)

## Media Management & Downloads
- [x] Gluetun (VPN client) deployed
- [x] Deluge (BitTorrent client) deployed via Gluetun
- [x] Gluetun Deluge Port Manager deployed
- [x] Prowlarr (Indexer Manager) deployed via Gluetun
- [x] Plex Media Server deployed with GPU passthrough
- [x] Radarr (Movie Management) deployed
- [x] Huntarr deployed
- [x] Sonarr (TV Show Management) deployed
- [x] 4K Radarr (4K Movie Management) deployed
- [x] 4K Sonarr (4K TV Show Management) deployed

## Permissions & File Management
- [ ] Review and ensure consistent permissions for application config and media directories (commented out tasks in `downloads`, `arrs`, `4k-arrs` roles)

## External Integrations
- [ ] Cloudflare Terraform setup

## Home Assistant VM
- [x] Working setup
- [x] reachable externally

## Maintenance & Operations
- [ ] Regular updates applied
- [ ] Backups configured
- [ ] Monitoring in place
- [ ] Comprehensive usage instructions provided
- [ ] Troubleshooting guide available
- [ ] Notifications
