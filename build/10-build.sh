#!/usr/bin/bash

set -eoux pipefail

###############################################################################
# Main Build Script - Ubuntu Edition
###############################################################################
# This script installs ubuntu-desktop and configures the system
###############################################################################

echo "::group:: Install Ubuntu Desktop"

# Update package lists
apt-get update

# Install ubuntu-desktop
export DEBIAN_FRONTEND=noninteractive
apt-get install -y ubuntu-desktop-minimal

echo "::endgroup::"

echo "::group:: Copy Custom Files"

# Copy Brewfiles to standard location (if using homebrew)
mkdir -p /usr/share/ublue-os/homebrew/
if [ -d /ctx/custom/brew ]; then
    cp /ctx/custom/brew/*.Brewfile /usr/share/ublue-os/homebrew/ 2>/dev/null || true
fi

# Consolidate Just Files (if using ujust)
mkdir -p /usr/share/ublue-os/just/
if [ -d /ctx/custom/ujust ]; then
    find /ctx/custom/ujust -iname '*.just' -exec printf "\n\n" \; -exec cat {} \; >> /usr/share/ublue-os/just/60-custom.just 2>/dev/null || true
fi

# Copy Flatpak preinstall files (if using flatpak)
mkdir -p /etc/flatpak/preinstall.d/
if [ -d /ctx/custom/flatpaks ]; then
    cp /ctx/custom/flatpaks/*.preinstall /etc/flatpak/preinstall.d/ 2>/dev/null || true
fi

echo "::endgroup::"

echo "::group:: System Configuration"

# Enable/disable systemd services as needed
# Example: systemctl enable podman.socket
# Example: systemctl mask unwanted-service

echo "::endgroup::"

echo "Custom build complete!"
