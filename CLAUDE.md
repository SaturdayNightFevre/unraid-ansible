# Unraid Ansible Project

## Project Structure
- **Main playbook**: `ansible/playbook.yml` - Orchestrates deployment in layers (runner → security → web → downloads → media)
- **Variables**: `ansible/vars.yml` - Central configuration for domains, paths, users, and service settings
- **Roles**: `ansible/roles/` - Service-specific deployment logic organized by function
- **Shared tasks**: `ansible/shared-tasks/` - Common Docker and permission management tasks
- **Templates**: `ansible/roles/*/templates/` - Jinja2 configuration templates for services

## Deployment Workflow
- **Main branch**: Automatic deployment via GitHub Actions (`/.github/workflows/deploy.yml`)
- **Pull requests**: Validation and dry-run checks via GitHub Actions (`/.github/workflows/plan.yml`)
- **No local deployment**: All deployments happen through GitHub Actions with WireGuard VPN connection

## GitHub Actions Commands
```bash
# Validation workflow (runs on PRs)
ansible-playbook -i /tmp/inventory.ini ansible/playbook.yml --syntax-check
ansible-playbook -i /tmp/inventory.ini ansible/playbook.yml --check --diff

# Deployment workflow (runs on main branch)
ansible-playbook -i /tmp/inventory.ini ansible/playbook.yml
```

## Service Architecture
**Deployment layers (in order):**
1. **Runner**: Ansible environment setup
2. **Security**: Database (PostgreSQL/Redis), Authentik identity provider, Crowdsec threat detection
3. **Web**: Traefik reverse proxy, DuckDNS, SSL certificates
4. **Downloads**: Gluetun VPN, Deluge torrent client, Prowlarr indexer
5. **Media**: Plex Media Server, Sonarr/Radarr (standard + 4K variants)

## Key Paths & Configuration
- **App data**: `/mnt/user/appdata/` - Container configurations
- **Media**: `/mnt/user/media/` - Media files storage
- **Downloads**: `/mnt/user/downloads/` - Download staging area
- **Domain**: `johnflix.uk` - Main domain for services
- **Local IP**: `192.168.1.10` - Unraid server IP
- **User/Group**: PUID=99, PGID=100 (standard Unraid user)

## Environment Variables (GitHub Secrets)
```
EMAIL - Admin email for certificates
DUCK_DNS_TOKEN - DuckDNS API token
CF_KEY - Cloudflare API key
DOMAIN - Main domain name
PASSWORD - Service admin password
PASSWORD_HASH - Hashed password for Authentik
OPENVPN_USER/OPENVPN_PASSWORD - VPN credentials
CROWDSEC_API - Crowdsec API key
SONARR_API_KEY/RADARR_API_KEY - Media management API keys
DELUGE_PASSWORD - Torrent client password
```

## Development Workflow
- **Feature branches**: Create branches for new features/changes
- **Pull requests**: Trigger validation workflow (syntax check + dry run)
- **Merge to main**: Triggers full deployment
- **Future**: Plan to deploy only changed roles instead of full stack

## Common Role Patterns
- **Shared tasks**: Use `ansible/shared-tasks/docker-app.yml` for standard Docker deployments
- **Templates**: Jinja2 templates in `roles/*/templates/` for dynamic configuration
- **Health checks**: Most services include Docker health checks and wait conditions
- **Security**: All containers run with security_opt, read-only where possible, resource limits
- **Networking**: Services use `web` network for Traefik integration

## Troubleshooting
- **Logs**: Check GitHub Actions workflow logs for deployment issues
- **Service status**: All services deployed via Docker on Unraid
- **Network**: Services accessible via `*.johnflix.uk` through Traefik
- **Validation**: Always run syntax check and dry run before deployment

## Code Style
- **YAML**: 2-space indentation, quotes around strings with special characters
- **Jinja2**: Use `{{ variable }}` for templating, `{% %}` for logic
- **Docker**: Consistent resource limits (1g memory, 1 CPU), security options
- **Naming**: Use descriptive container names, follow existing patterns

## Security Practices
- **No secrets in code**: All sensitive data via GitHub Secrets
- **Container security**: AppArmor profiles, no-new-privileges, read-only containers
- **Network isolation**: Separate networks for different service layers
- **Access control**: Authentik for identity management, Crowdsec for threat detection
- **SSL/TLS**: Automatic certificate management via Traefik + Let's Encrypt