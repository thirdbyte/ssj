#!/bin/bash

function check {

    if ! docker --version &>/dev/null; then
        echo "Docker is not installed. Terminating..."
        exit 1
    fi

    if ! groups | grep -q "docker"; then
        echo "The user '$USER' is not present in the 'docker' group. Terminating..."
        exit 1
    fi

    if ! git --version &>/dev/null; then
        echo "Git is not installed. Terminating..."
        exit 1
    fi

    if ! ping -q -c 1 -W 1 github.com &>/dev/null; then
        echo "Could not connect to the Internet. Terminating..."
        exit 1
    fi

}

function init_dir {

    mkdir -p $HOME/.ssj
    mkdir -p $HOME/.local/bin
    mkdir -p $HOME/.local/share/applications
    mkdir -p $HOME/.local/share/icons

}

function cp_files {

    cp -r /tmp/ssj/home/. $HOME/.ssj/
    cp /tmp/ssj/files/ssj $HOME/.local/bin/
    cp /tmp/ssj/files/ssj.desktop $HOME/.local/share/applications/
    cp /tmp/ssj/files/ssj.png $HOME/.local/share/icons/

}

function add_path {

    if ! echo $PATH | grep -q "$HOME/.local/bin"; then
        echo 'export PATH=$HOME/.local/bin:$PATH' >> $HOME/.bashrc
        source $HOME/.bashrc
    fi

}

check

docker pull ghcr.io/thirdbyte/ssj:latest && \
git clone https://github.com/thirdbyte/ssj /tmp/ssj && \
init_dir && \
cp_files && \
chmod +x $HOME/.local/bin/ssj && \
add_path && \
rm -rf /tmp/ssj && \
echo "" && \
echo "Installation successful! Please reboot."

docker image rm $(docker images -q --filter "dangling=true") &>/dev/null
