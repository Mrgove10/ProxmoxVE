#!/usr/bin/env bash

# Copyright (c) 2024 Adrien R.
# Author: Adrien R.
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y \
  sudo \
  apt-transport-https \
  debconf \
  gnupg \
  procps\
  adduser 
msg_ok "Installed Dependencies"

msg_info "Installing Wazuh Repo"
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | gpg --no-default-keyring --keyring gnupg-ring:/usr/share/keyrings/wazuh.gpg --import && chmod 644 /usr/share/keyrings/wazuh.gpg
echo "deb [signed-by=/usr/share/keyrings/wazuh.gpg] https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
apt-get update
msg_ok "Installed Wazuh Repo"

msg_info "Installing Wazuh Server All in one"
curl -sO https://packages.wazuh.com/4.9/wazuh-install.sh && sudo bash ./wazuh-install.sh -a
msg_ok "Installed Wazuh Indexer"