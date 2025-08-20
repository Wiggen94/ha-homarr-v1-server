#!/bin/sh

# Create required directories for Homarr v1
mkdir -p /share/homarrv1/db
mkdir -p /share/homarrv1/redis
mkdir -p /share/homarrv1/trusted-certificates

# Set environment variables for Homarr v1
export DB_URL='/share/homarrv1/db/db.sqlite'
export DB_DIALECT='sqlite'
export DB_DRIVER='better-sqlite3'
export AUTH_PROVIDERS='credentials'
export REDIS_IS_EXTERNAL='false'
export NODE_ENV='production'
export DB_MIGRATIONS_DISABLED='false'
export SECRET_ENCRYPTION_KEY='dc4a514fc67b4f4e629a99b019759f9f32dc4facb55ff2c1a51862597edfcd6e'

# Exporting hostname for nginx configuration
echo "Exporting hostname..."
export HOSTNAME="${HOSTNAME:-localhost}"

# Run the original Homarr v1 entrypoint and run script
echo "Starting Homarr v1..."
exec /app/entrypoint.sh sh /app/run.sh
