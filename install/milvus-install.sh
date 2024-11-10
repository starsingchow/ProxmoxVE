#!/usr/bin/env bash

source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"
color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Dependencies"
$STD apt-get install -y curl
$STD apt-get install -y net-tools
$STD apt-get install -y sudo
$STD apt-get install -y mc
msg_ok "Installed Dependencies"

msg_info "Installing milvus (patience)"
wget -q https://github.com/milvus-io/milvus/releases/download/v2.3.10/milvus_2.3.10-1_amd64.deb
$STD apt-get update
$STD dpkg -i milvus_2.3.10-1_amd64.deb
$STD apt-get -f install
$STD rm milvus_2.3.10-1_amd64.deb
msg_ok "Installed milvus"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
