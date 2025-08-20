# Homarr v1 Migration Notes

## Overview
This document outlines the technical changes made to migrate this Home Assistant addon from Homarr v0.x to Homarr v1.

## Key Changes

### 1. Docker Image
- **Old**: `ghcr.io/ajnart/homarr:latest`
- **New**: `ghcr.io/homarr-labs/homarr:latest`

### 2. Data Structure Changes
- **Old**: Used `/app/data/configs`, `/data`, and `/app/public/icons`
- **New**: Uses `/share/homarrv1/` as the main data directory with subdirectories:
  - `/share/homarrv1/db/` - SQLite database files (boards, users, integrations, etc.)
  - `/share/homarrv1/redis/` - Redis data for caching and sessions
  - `/share/homarrv1/trusted-certificates/` - SSL certificates
- **Icons**: No longer managed separately - built into the application

### 3. Architecture Changes
- **Old**: Single Node.js application
- **New**: Multi-service architecture with:
  - Nginx proxy
  - Redis server
  - Tasks API
  - WebSocket server
  - Next.js frontend/backend

### 4. Environment Variables
- **Old**: Used `NEXTAUTH_URL_INTERNAL`
- **New**: Uses multiple environment variables:
  - `DB_URL='/share/homarrv1/db/db.sqlite'`
  - `DB_DIALECT='sqlite'`
  - `DB_DRIVER='better-sqlite3'`
  - `AUTH_PROVIDERS='credentials'`
  - `REDIS_IS_EXTERNAL='false'`
  - `NODE_ENV='production'`
  - `DB_MIGRATIONS_DISABLED='false'`
  - `HOSTNAME` for nginx configuration
  - `SECRET_ENCRYPTION_KEY` - **REQUIRED** 64-character hex string for data encryption

### 5. Startup Process
- **Old**: Direct Node.js server startup
- **New**: Uses entrypoint script and run script with multiple services

### 6. Data Storage
- **Old**: JSON configuration files
- **New**: SQLite database with proper schema
- **Path**: `/share/homarrv1/db/db.sqlite` - accessible via Samba

## Migration Process

### ⚠️ IMPORTANT: Manual Migration Required
**Migration from Homarr v0.x to v1 is NOT automatic!** Users must manually export their data from the old version and import it into the new version.

**For detailed migration instructions, see the [official Homarr migration guide](https://homarr.dev/blog/2025/01/19/migration-guide-1.0/).**

### For Users Upgrading from v0.x:
1. **Export from v0.x**: 
   - Go to your old Homarr v0.x dashboard
   - Navigate to `Management` > `Tools` > `Migrate to 1.0`
   - Export your boards and configurations
   - Save the export file and note the secret key
2. **Install v1**: Install the new Homarr v1 addon
3. **Import to v1**: 
   - Go to the new Homarr v1 dashboard
   - During onboarding, select `Import from Homarr before 1.0`
   - Upload your exported zip file
   - Enter the secret key when prompted
4. **Access**: Same URL: `http://<your-home-assistant-ip>:7575`

### For New Users:
1. **Install**: Install the Homarr v1 addon
2. **Access**: Navigate to `http://<your-home-assistant-ip>:7575`
3. **Setup**: Follow the initial setup wizard

### For Developers:
1. **Dockerfile**: Updated to use new base image
2. **run.sh**: Completely rewritten for new architecture with proper data persistence
3. **config.yaml**: Updated version and share directory mapping
4. **README.md**: Updated to reflect v1 changes and migration guide

## Breaking Changes
- **Database format**: Completely different (SQLite vs JSON files)
- **Configuration structure**: New schema and data organization
- **Features**: Some features may have been renamed or moved
- **Migration**: Manual export/import required - no automatic migration
- **NEW**: SECRET_ENCRYPTION_KEY is now required for data encryption
- **Icons**: No longer managed as separate files - built into the application
- **Data Storage**: All data now stored in SQLite database instead of JSON files

## Troubleshooting
If you encounter issues after migration:
1. Check the addon logs for error messages
2. Ensure your Home Assistant has enough resources (v1 uses more memory)
3. Try restarting the addon
4. If problems persist, you may need to clear the data and start fresh
5. **NEW**: If you see "SECRET_ENCRYPTION_KEY is required" error, ensure the environment variable is set
6. **Data Loss**: If boards/items are missing, check that the `/share/homarrv1/db/` directory contains the database file
7. **CPU Warnings**: You may see CPU compatibility warnings in logs - these are harmless and don't affect functionality

## Known Issues
- **CPU Compatibility Warnings**: Some users may see warnings like "CPU supports 0x6000000000004000, software requires 0x4000000000005000" - these are harmless and don't affect functionality
- **Redis Memory Warning**: "Memory overcommit must be enabled" warning is normal and doesn't affect operation
- **Node.js Deprecation Warnings**: Various deprecation warnings may appear in logs but don't affect functionality

## Support
For issues specific to this addon, please open an issue on the GitHub repository.
For general Homarr v1 issues, check the [official documentation](https://homarr.dev/docs/).
