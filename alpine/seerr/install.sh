#!/bin/bash
set -euo pipefail

REPO="https://github.com/Fallenbagel/jellyseerr.git"
BUILD_DIR="/home/container/jellyseerr"
TARGET="/mnt/server/jellyseerr"
OLD="/mnt/server/jellyseerr.old"
CONFIG_BACKUP="/mnt/server/jellyseerr-config-backup-$(date +%F-%H%M%S)"

# --- 1. Build in staging (the live install is not touched yet) ---
rm -rf "$BUILD_DIR"
git clone "$REPO" "$BUILD_DIR"
cd "$BUILD_DIR"
git checkout main

CYPRESS_INSTALL_BINARY=0 pnpm install --frozen-lockfile
pnpm build

mkdir -p /mnt/server

# --- 2. Fresh install or update ---
if [ -d "$TARGET" ]; then
    echo "Existing install found, updating..."

    # Backup of the persistent data, kept separately and never overwritten
    if [ -d "$TARGET/config" ]; then
        cp -a "$TARGET/config" "$CONFIG_BACKUP"
    fi

    # Swap: old app aside, new build in
    rm -rf "$OLD"
    mv "$TARGET" "$OLD"
    mv "$BUILD_DIR" "$TARGET"

    # Restore persistent data (remove any config dir shipped with the new
    # source first, otherwise cp would nest the folder)
    rm -rf "$TARGET/config"
    if [ -d "$OLD/config" ]; then
        cp -a "$OLD/config" "$TARGET/config"
    fi
    if [ -f "$OLD/.env" ]; then
        cp -a "$OLD/.env" "$TARGET/.env"
    fi

    # Sanity check: abort loudly if the settings didn't make it over
    if [ -f "$OLD/config/settings.json" ] && [ ! -f "$TARGET/config/settings.json" ]; then
        echo "ERROR: settings.json missing after update, restore from $OLD or $CONFIG_BACKUP" >&2
        exit 1
    fi
else
    echo "No existing install, doing a fresh install..."
    mv "$BUILD_DIR" "$TARGET"
fi

echo "Done."
