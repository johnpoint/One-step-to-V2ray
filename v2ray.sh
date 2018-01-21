#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

sh_ver="2.2.16"
echo -e "正在下载新版安装脚本~"
wget https://github.com/johnpoint/One-step-to-V2ray/raw/master/v2ray-base.sh && chmod +x v2ray-base.sh && ./v2ray-base.sh