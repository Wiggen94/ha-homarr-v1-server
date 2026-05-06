ARG HOMARR_IMAGE=ghcr.io/homarr-labs/homarr:latest
ARG APP_BASE=ghcr.io/hassio-addons/base:stable

FROM ${APP_BASE} AS ha_base

FROM ${HOMARR_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Ensure bash exists for startup wrapper
RUN if command -v apk >/dev/null 2>&1; then \
			apk add --no-cache bash jq curl; \
		elif command -v apt-get >/dev/null 2>&1; then \
			apt-get update && apt-get install -y --no-install-recommends bash jq curl && rm -rf /var/lib/apt/lists/*; \
		fi

# Bring in bashio from Home Assistant base while keeping Homarr runtime dependencies
COPY --from=ha_base /usr/lib/bashio /usr/lib/bashio
COPY --from=ha_base /usr/bin/bashio /usr/bin/bashio

# Add-on startup wrapper
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh \
		&& if [ -f /app/entrypoint.sh ]; then chmod +x /app/entrypoint.sh; fi \
		&& if [ -f /app/run.sh ]; then chmod +x /app/run.sh; fi

CMD ["/app/startup.sh"]