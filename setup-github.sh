#!/bin/bash
set -u -e

sudo apt update
sudo apt -y install gh
gh auth login
git config --global user.name kakt
git config --global user.email kakt@example.com
