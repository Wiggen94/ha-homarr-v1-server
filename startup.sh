#!/usr/bin/env bash
# shellcheck shell=bash
set -euo pipefail

source /usr/lib/bashio/bashio.sh

set_if_bashio_value() {
    local env_var="$1"
    local key="$2"
    if bashio::config.has_value "$key"; then
        export "$env_var=$(bashio::config "$key")"
    fi
}

add_auth_provider() {
    local provider="$1"
    if [[ -n "${AUTH_PROVIDERS:-}" ]]; then
        export AUTH_PROVIDERS="${AUTH_PROVIDERS},${provider}"
    else
        export AUTH_PROVIDERS="${provider}"
    fi
}

# Create necessary directories for database, Redis, and trusted certificates
mkdir -p /share/homarrv1/db /share/homarrv1/redis /share/homarrv1/trusted-certificates

export REDIS_IS_EXTERNAL='false'
export NODE_ENV='production'
export DB_MIGRATIONS_DISABLED='false'

# Docker socket proxy configuration
if bashio::config.true 'docker_socket_proxy.docker_proxy_enabled'; then
    echo "Docker socket proxy is enabled."
    set_if_bashio_value DOCKER_HOSTNAMES 'docker_socket_proxy.docker_hostnames'
    set_if_bashio_value DOCKER_PORTS 'docker_socket_proxy.docker_ports'
fi

# Database configuration
export DB_URL="$(bashio::config 'database.db_url')"
export DB_DIALECT="$(bashio::config 'database.db_dialect')"
set_if_bashio_value DB_HOST 'database.db_host'
set_if_bashio_value DB_PORT 'database.db_port'
set_if_bashio_value DB_NAME 'database.db_name'
set_if_bashio_value DB_USER 'database.db_user'
set_if_bashio_value DB_PASSWORD 'database.db_password'

# Authentication configuration
if bashio::config.true 'security.auth_credentials_enabled'; then
    add_auth_provider 'credentials'
fi
set_if_bashio_value AUTH_LOGOUT_REDIRECT_URL 'security.auth_logout_redirect_url'
export AUTH_SESSION_EXPIRY_TIME="$(bashio::config 'security.auth_session_expiry_time')"
export SECRET_ENCRYPTION_KEY="$(bashio::config 'security.secret_encryption_key')"

# OIDC authentication provider configuration
if bashio::config.true 'auth_oidc.auth_oidc_enabled'; then
    echo "Configuring OIDC authentication provider..."
    add_auth_provider 'oidc'

    set_if_bashio_value AUTH_OIDC_ISSUER 'auth_oidc.auth_oidc_issuer'
    set_if_bashio_value AUTH_OIDC_CLIENT_ID 'auth_oidc.auth_oidc_client_id'
    set_if_bashio_value AUTH_OIDC_CLIENT_SECRET 'auth_oidc.auth_oidc_client_secret'
    set_if_bashio_value AUTH_OIDC_CLIENT_NAME 'auth_oidc.auth_oidc_client_name'
    set_if_bashio_value AUTH_OIDC_AUTO_LOGIN 'auth_oidc.auth_oidc_auto_login'
    set_if_bashio_value AUTH_OIDC_SCOPE_OVERWRITE 'auth_oidc.auth_oidc_scope_overwrite'
    set_if_bashio_value AUTH_OIDC_GROUPS_ATTRIBUTE 'auth_oidc.auth_oidc_groups_attribute'
    set_if_bashio_value AUTH_OIDC_NAME_ATTRIBUTE_OVERWRITE 'auth_oidc.auth_oidc_name_attribute_overwrite'
    set_if_bashio_value AUTH_OIDC_FORCE_USERINFO 'auth_oidc.auth_oidc_force_userinfo'
    set_if_bashio_value AUTH_OIDC_ENABLE_DANGEROUS_ACCOUNT_LINKING 'auth_oidc.auth_oidc_enable_dangerous_account_linking'
fi

# LDAP authentication provider configuration
if bashio::config.true 'auth_ldap.auth_ldap_enabled'; then
    echo "Configuring LDAP authentication provider..."
    add_auth_provider 'ldap'

    set_if_bashio_value AUTH_LDAP_URI 'auth_ldap.auth_ldap_uri'
    set_if_bashio_value AUTH_LDAP_BASE 'auth_ldap.auth_ldap_base'
    set_if_bashio_value AUTH_LDAP_BIND_DN 'auth_ldap.auth_ldap_bind_dn'
    set_if_bashio_value AUTH_LDAP_BIND_PASSWORD 'auth_ldap.auth_ldap_bind_password'
    set_if_bashio_value AUTH_LDAP_USERNAME_ATTRIBUTE 'auth_ldap.auth_ldap_username_attribute'
    set_if_bashio_value AUTH_LDAP_USER_MAIL_ATTRIBUTE 'auth_ldap.auth_ldap_user_mail_attribute'
    set_if_bashio_value AUTH_LDAP_GROUP_CLASS 'auth_ldap.auth_ldap_group_class'
    set_if_bashio_value AUTH_LDAP_GROUP_MEMBER_ATTRIBUTE 'auth_ldap.auth_ldap_group_member_attribute'
    set_if_bashio_value AUTH_LDAP_GROUP_MEMBER_USER_ATTRIBUTE 'auth_ldap.auth_ldap_group_member_user_attribute'
    set_if_bashio_value AUTH_LDAP_SEARCH_SCOPE 'auth_ldap.auth_ldap_search_scope'
    set_if_bashio_value AUTH_LDAP_USERNAME_FILTER_EXTRA_ARG 'auth_ldap.auth_ldap_username_filter_extra_arg'
    set_if_bashio_value AUTH_LDAP_GROUP_FILTER_EXTRA_ARG 'auth_ldap.auth_ldap_group_filter_extra_arg'
fi

# Select the appropriate database driver based on the specified dialect
case "${DB_DIALECT}" in
    sqlite)
        export DB_DRIVER='better-sqlite3'
        ;;
    postgresql)
        export DB_DRIVER='node-postgres'
        ;;
    mysql)
        export DB_DRIVER='mysql2'
        ;;
    *)
        echo "Unsupported database dialect: ${DB_DIALECT}"
        exit 1
        ;;
esac

echo "Selected database dialect: ${DB_DIALECT}"
export HOSTNAME="${HOSTNAME:-localhost}"

echo "Starting Homarr..."
if [[ -x /app/entrypoint.sh ]]; then
    exec /app/entrypoint.sh sh /app/run.sh
fi

exec sh /app/run.sh