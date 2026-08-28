#!/usr/bin/env bash
CWD="$(cd "$(dirname "$0")" && pwd)"
sudo ln -sbnv "$CWD/configuration.nix" /etc/nixos/configuration.nix
sudo ln -sbnv "$CWD/home.nix" /etc/nixos/home.nix

