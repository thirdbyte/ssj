FROM kalilinux/kali-last-release

RUN echo "deb http://kali.download/kali kali-last-snapshot main contrib non-free" > /etc/apt/sources.list && \
   apt-get -y update && \
   apt-get -y dist-upgrade && \
   DEBIAN_FRONTEND=noninteractive apt-get install -y nano curl wget git ncat dbus-x11 python2 python3 python3-pip p7zip-full p7zip-rar p7zip unzip net-tools build-essential iputils-ping pciutils iproute2 bash-completion kali-linux-large kali-linux-headless pcmanfm leafpad terminator tmux && \
   apt-get -y autoremove && \
   apt-get -y clean && \
   rm -rf /var/lib/apt/lists/* && \
   mkdir -p /usr/local/bin && \
   echo '#!/bin/bash' > /usr/local/bin/gui && \
   echo '$@ &>/dev/null &' >> /usr/local/bin/gui && \
   chmod +x /usr/local/bin/gui && \   
   wget https://raw.githubusercontent.com/thirdbyte/ssj/main/home/.bashrc -O /root/.bashrc && \
   touch /root/.hushlogin && \
   echo 'set -g history-limit 10000' > /root/.tmux.conf

CMD ["/usr/bin/terminator"]
