#!/bin/sh

mkdir -p "$CONFIG_PATH"
mkdir -p "$FILE_PATH"

if [[ -z "${DEBUG}" ]]; then
  HTTP_DEBUG="false"
else
  HTTP_DEBUG="${DEBUG}"
fi

if [[ -z "${UDID_WARN_ONLY}" ]]; then
  UDID_WARN_ONLY="false"
fi

exec /micromdm serve \
    -api-key="$(cat $API_KEY_PATH)" \
    -tls=false \
    -scep-client-validity=3650 \
    -http-addr="$PORT" \
    -http-proxy-headers=true \
    -http-debug="$HTTP_DEBUG" \
    -config-path="$CONFIG_PATH" \
    -filerepo="$FILE_PATH" \
    -server-url="$SERVER_URL" \
    -udid-cert-auth-warn-only="$UDID_WARN_ONLY" \
    -command-webhook-url="$WEBHOOK_URL"
