#! /bin/bash
installJdk() {
  echo "**************安装jdk"
  chmod +x jdk-8u111-linux-x64.rpm
  rpm -ivh jdk-8u111-linux-x64.rpm
  echo "JAVA_HOME=/usr/java/jdk1.8.0_111" >>/etc/profile
  echo "CLASSPATH=.:$JAVA_HOME/lib.tools.jar" >>/etc/profile
  echo "PATH=$JAVA_HOME/bin:$PATH" >>/etc/profile
  echo "export JAVA_HOME CLASSPATH PATH" >>/etc/profile
}
if [[ -d "/usr/java/jdk1.8.0_111" ]]; then
  echo "**************jdk已经安装,跳过"
else
  installJdk
fi
