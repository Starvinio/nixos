#!/usr/bin/env bash
set -euo pipefail

HOME_MANAGER_CHANNEL="https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz"

sudo nix-channel --add "$HOME_MANAGER_CHANNEL" home-manager
sudo nix-channel --update home-manager
