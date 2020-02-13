#!/bin/sh

mkdir -p "$CONFIG_PATH"
mkdir -p "$FILE_PATH"

exec /micromdm serve \
    -api-key="$(cat $API_KEY_PATH)" \
    -tls=false \
    -scep-client-validity=3650 \
    -http-addr="$PORT" \
    -config-path="$CONFIG_PATH" \
    -filerepo="$FILE_PATH" \
    -server-url="$SERVER_URL" \
    -command-webhook-url="$WEBHOOK_URL"
