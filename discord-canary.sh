#!/bin/bash
FLATPAK_ID=${FLATPAK_ID:-"com.discordapp.DiscordCanary"}
socat $SOCAT_ARGS \
    UNIX-LISTEN:$XDG_RUNTIME_DIR/app/${FLATPAK_ID}/discord-ipc-0,forever,fork \
    UNIX-CONNECT:$XDG_RUNTIME_DIR/discord-ipc-0 \
    &
socat_pid=$!
env TMPDIR=$XDG_CACHE_HOME zypak-wrapper /app/discord-canary/DiscordCanary "$@"
kill -SIGTERM $socat_pid
