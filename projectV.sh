#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#=================================================
#	System Required: Ubuntu 14.04+
#	Version: 0.0.1
#	Blog: johnpoint.github.io
#	Author: johnpoint
#    USE AT YOUR OWN RISK!!!
#    Publish under GNU General Public License v2
#=================================================

sh_ver="0.0.1"
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[信息]${Font_color_suffix}"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"
Tip="${Green_font_prefix}[注意]${Font_color_suffix}"
Separator_1="——————————————————————————————"

 #Check Root 
 [ $(id -u) != "0" ] && { echo "${CFAILURE}Error: You must be root to run this script${CEND}"; exit 1; } 
  
 Install_Basic_Packages(){
 apt update
 apt install curl wget unzip ntp jq ntpdate -y 
  }
  
 Set_DNS(){
 echo "nameserver 8.8.8.8" > /etc/resolv.conf 
 echo "nameserver 8.8.4.4" >> /etc/resolv.conf 
  }
  
 Update_NTP_settings(){
 rm -rf /etc/localtime 
 ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 
 ntpdate us.pool.ntp.org
 }
 
 Disable_SELinux(){
 if [ -s /etc/selinux/config ] && grep 'SELINUX=enforcing' /etc/selinux/config; then 
 sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config 
 setenforce 0 
 fi 
 }
 
 
 Update_shell(){
	echo -e "当前版本为 [ ${Green_font_prefix}${sh_ver}${Font_color_suffix} ]，开始检测最新版本..."
	sh_new_ver=$(wget --no-check-certificate -qO- "https://github.com/johnpoint/One-step-to-V2ray/raw/master/projectV.sh"|grep 'sh_ver="'|awk -F "=" '{print $NF}'|sed 's/\"//g'|head -1)
	[[ -z ${sh_new_ver} ]] && echo -e "${Error} 检测最新版本失败 !" && exit 0
	if [[ ${sh_new_ver} != ${sh_ver} ]]; then
		echo -e "发现新版本[ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ]，是否更新？[y/n]"
		stty erase '^H' && read -p "(默认: y):" yn
		[[ -z "${yn}" ]] && yn="y"
		if [[ ${yn} == [yY] ]]; then
			rm -rf projectV.sh
			wget https://github.com/johnpoint/One-step-to-V2ray/raw/master/v2ray.sh
			echo -e "脚本已更新为最新版本[ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ] !"
            chmod +x projectV.sh
            ./projectV.sh
            exit
		else
			echo && echo "	已取消..." && echo
		fi
	else
		echo -e "当前已是最新版本[ ${Green_font_prefix}${sh_new_ver}${Font_color_suffix} ] !"
	fi
}


 Start(){
 echo -e "${Info} 正在开启v2ray"
service v2ray start 
}

Stop(){
 echo -e "${Info} 正在关闭v2ray"
service v2ray stop
}

Restart(){
Stop
Start
}

Status(){
service v2ray status
}
 
 Install_main(){
 cd ~
 echo -e "${Tip} 正在使用官方脚本安装v2ray主程序...."
 bash <(curl -L -s https://install.direct/go.sh)
 echo -e "${Tip} 安装完成~"
 }
 
 Disable_iptables(){
 iptables -P INPUT ACCEPT 
 iptables -P FORWARD ACCEPT 
 iptables -P OUTPUT ACCEPT 
 iptables -F 
}




Update_shell
clear
echo  -e "v2ray安装/管理脚本 [v${Green_font_prefix}${sh_ver}${Font_color_suffix}]
———— Author:johnpoint ————

  ${Green_font_prefix}1.${Font_color_suffix} 安装 v2ray
  ${Green_font_prefix}2.${Font_color_suffix} 卸载 v2ray
  ——————————————————————
  ${Green_font_prefix}3.${Font_color_suffix} 设置 log
  ${Green_font_prefix}4.${Font_color_suffix} 设置 DNS
  ${Green_font_prefix}5.${Font_color_suffix} 设置 routing
  ${Green_font_prefix}6.${Font_color_suffix} 设置 policy
  ${Green_font_prefix}7.${Font_color_suffix} 设置 inbound
  ${Green_font_prefix}8.${Font_color_suffix} 设置 outbound
  ${Green_font_prefix}9.${Font_color_suffix} 设置 inboundDetour
  ${Green_font_prefix}9.${Font_color_suffix} 设置 outboundDetour
  ${Green_font_prefix}9.${Font_color_suffix} 设置 transport
  ——————————————————————
  ${Green_font_prefix}9.${Font_color_suffix} 服务 命令
  ${Green_font_prefix}00.${Font_color_suffix} 更新 主程序
  ${Green_font_prefix}0.${Font_color_suffix} 更新 脚本
"
read mainset
if [[ ${mainset} == '1' ]]; then
	Set_type
elif [[ ${mainset} == '2' ]]; then
	Uninstall
elif [[ ${mainset} == '3' ]]; then
	Cg_user
elif [[ ${mainset} == '4' ]]; then
	Cg_service
elif [[ ${mainset} == '5' ]]; then
	View_config
elif [[ ${mainset} == '6' ]]; then
	Start
elif [[ ${mainset} == '7' ]]; then
	Stop
elif [[ ${mainset} == '8' ]]; then
	Restart
elif [[ ${mainset} == '9' ]]; then
	Status
elif [[ ${mainset} == '0' ]]; then
	Update_shell
elif [[ ${mainset} == '00' ]]; then
	Install_main
else
	echo "输入不正确!"
	exit 0
fi