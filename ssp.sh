#!/bin/bash
#fonts color
Green="\033[32m"
Red="\033[31m"
#Yellow="\033[33m"
GreenBG="\033[42;37m"
RedBG="\033[41;37m"
YellowBG="\033[43;37m"
Font="\033[0m"
#notification information
# Info="${Green}[信息]${Font}"
OK="${Green}[OK]${Font}"
Error="${Red}[错误]${Font}"
Warning="${Red}[警告]${Font}"

#解决BachSpace键出现^H的情况
stty erase ^H

source /etc/os-release

    if [[ "${ID}" == "centos" && ${VERSION_ID} -ge 7 ]]; then
        echo -e "${GreenBG} 当前系统为 Centos ${VERSION_ID} ${VERSION} ${Font}"
        INS="yum"
    elif [[ "${ID}" == "debian" && ${VERSION_ID} -ge 8 ]]; then
        echo -e "${GreenBG} 当前系统为 Debian ${VERSION_ID} ${VERSION} ${Font}"
        INS="apt"
        $INS update -y
        ## 添加 Nginx apt源
    elif [[ "${ID}" == "ubuntu" && $(echo "${VERSION_ID}" | cut -d '.' -f1) -ge 16 ]]; then
        echo -e "${GreenBG} 当前系统为 Ubuntu ${VERSION_ID} ${UBUNTU_CODENAME} ${Font}"
        INS="apt"
        $INS update -y
    else
        echo -e "${Error} ${RedBG} 当前系统为 ${ID} ${VERSION_ID} 不在支持的系统列表内，安装中断 ${Font}"
        exit 1
    fi

if command -v curl >> /dev/null 2>&1;
  then
    echo -e "${GreenBG} curl已安装 ${Font}"
  else
    echo -e "${RedBG} curl未被安装，正在进行安装 ${Font}"
    ${INS} install -y curl >> /dev/null 2>&1
  fi
  
if command -v vim >> /dev/null 2>&1;
  then
    echo -e "${GreenBG} vim已安装 ${Font}"
  else
    echo -e "${RedBG} vim未被安装，正在进行安装 ${Font}"
    ${INS} install -y vim >> /dev/null 2>&1
  fi

curl -o /usr/bin/ssp -Ls https://xindada.tk/sh/ssp.sh
chmod +x /usr/bin/ssp

    echo -e "\t ${Green}Linux脚本整合${Font}"
    echo -e "\t--- by Xindada---"
    echo -e "\t---快捷呼出菜单：ssp---"
    echo -e "${Green}1.${Font}  使用最新BBr脚本"
    echo -e "${Green}2.${Font}  一键安装docker"
    echo -e "${Green}3.${Font}  重启Docker"
    echo -e "${Green}4.${Font}  一键安装soga"
    echo -e "${Green}5.${Font} 添加Swap"
    echo -e "${Green}6.${Font} 关闭防火墙"
    echo -e "${Green}==========工具类=========="
    echo -e "${Green}7.${Font} SuperBench测速"
    echo -e "${Green}8.${Font} LemonBench测速"
    echo -e "${Green}9.${Font} 回程路由"
    echo -e "${Green}10.${Font} 安装iptables转发（natcfg）"
	
    sleep 1
	read -rp "请输入数字：" menu_num
    case $menu_num in
    1)
        wget -N --no-check-certificate "https://xindada.tk/sh/tcp.sh" && chmod +x tcp.sh && ./tcp.sh
        ;;
    2)
        docker version > /dev/null || curl -fsSL get.docker.com | bash
        ;;
    3)
        service docker restart
        ;;
    4)
        bash <(curl -Ls https://blog.sprov.xyz/soga.sh)
        ;;
    5)
        wget https://www.moerats.com/usr/shell/swap.sh && bash swap.sh
        ;;
    6)
        systemctl stop firewalld
        systemctl disable firewalld
        systemctl status  firewalld
        ;;
    7)
        wget -qO- https://raw.githubusercontent.com/oooldking/script/master/superbench.sh | bash
        ;;
    8)
       curl -fsL https://ilemonra.in/LemonBenchIntl | bash -s fast
        ;;
    9)
        wget -qO- git.io/besttrace | bash
        ;;
    10)
        wget -qO natcfg.sh http://arloor.com/sh/iptablesUtils/natcfg.sh && bash natcfg.sh
        ;;
		
    *)
        echo -e "${RedBG}请输入正确的数字${Font}"
        ;;
    esac
