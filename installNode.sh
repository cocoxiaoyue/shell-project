#! /bin/bash
# 颜色标志
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Error="${Red_font_prefix}[错误]${Font_color_suffix}"

# 验证当前登录的用户是否有管理员权限
check_root() {
  [[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1
}

# 加压缩安装包
tar_install() {
  if [[ ! -d "/opt/apps/node-v14.16.1-linux-x64" ]]; then
    echo "**************解压node"
    if test -e "./node-v14.16.1-linux-x64.tar.xz"; then
      echo "存在xz文件,先解压xz文件"
      xz -d node-v14.16.1-linux-x64.tar.xz
    fi
    echo "解压tar包node文件"
    tar -xf node-v14.16.1-linux-x64.tar
    mv node-v14.16.1-linux-x64 node
  fi
}

# 将node添加到环境中
add_nodeprofile() {
  # 备份环境配置文件
  cp /etc/profile /etc/profile.bak
  echo 'export PATH=$PATH:/opt/apps/node/bin' >>/etc/profile
}

# 检索权限
check_root
# 先创建软件下载、安装目录
mkdir /opt/apps
# 进入到该目录中
cd /opt/apps
# 先安装公网拉取工具
yum -y install wget
# 远程下载node安装包
wget https://nodejs.org/dist/v14.16.1/node-v14.16.1-linux-x64.tar.xz
# 解压安装包
tar_install
# 将node添加到系统的环境中
add_nodeprofile
