# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
#prompt colors and style
export PS1='\[\e[33m\][\u@\h:\[\e[1;34m\]\W\[\e[m\]] '

# set PATH
export JAVA_HOME=/opt/jdk
export PATH=$PATH:$JAVA_HOME/bin:/vagrant/bin

