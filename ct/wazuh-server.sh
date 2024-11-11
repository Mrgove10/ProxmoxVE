#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/community-scripts/Mrgove10/main/misc/build.func)
# Copyright (c) 2024 Adrien R.
# Author: Adrien R.
# License: MIT
# https://github.com/community-scripts/ProxmoxVE/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
 _       __                         __            _____
| |     / /  ____ _ ____  __  __   / /_          / ___/  ___    _____ _   __  ___    _____
| | /| / /  / __ `//_  / / / / /  / __ \         \__ \  / _ \  / ___/| | / / / _ \  / ___/
| |/ |/ /  / /_/ /  / /_/ /_/ /  / / / /        ___/ / /  __/ / /    | |/ / /  __/ / /
|__/|__/   \__,_/  /___/\__,_/  /_/ /_/        /____/  \___/ /_/     |___/  \___/ /_/
EOF
}
header_info
echo -e "Loading..."
APP="Wazuh-server"
var_disk="5"
var_cpu="2"
var_ram="1024"
var_os="debian"
var_version="12"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
if [[ ! -d /usr/lib/unifi ]]; then msg_error "No ${APP} Installation Found!"; exit; fi # TODO
msg_info "Updating ${APP}"
apt-get update --allow-releaseinfo-change
apt-get install -y wazuh-indexer
apt-get install -y wazuh-manager
apt-get install -y wazuh-dashboard
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} dashboard should be reachable by going to the following URL.
         ${BL}https://${IP}${CL} \n
         You can now install wWazuh agent on over servers \n
         "
