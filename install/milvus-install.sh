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
$STD apt-get install -y libaio-dev
msg_ok "Installed Dependencies"

msg_info "Installing milvus (patience)"
wget -q https://github.com/milvus-io/milvus/releases/download/v2.3.10/milvus_2.3.10-1_amd64.deb
wget -q https://github.com/zilliztech/attu/releases/download/v2.4.9/attu_2.4.9_amd64.deb
$STD apt-get update
$STD dpkg -i milvus_2.3.10-1_amd64.deb
$STD dpkg -i attu_2.4.9_amd64.deb 2>/dev/null
$STD apt-get -f install
$STD rm milvus_2.3.10-1_amd64.deb
$STD rm attu_2.4.9_amd64.deb
msg_ok "Installed milvus"

motd_ssh
customize

msg_info "Cleaning up"
$STD apt-get -y autoremove
$STD apt-get -y autoclean
msg_ok "Cleaned"
