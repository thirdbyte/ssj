# SSJ - Your everyday Linux distribution gone Super Saiyan.

![ssj](https://raw.githubusercontent.com/thirdbyte/ssj/main/files/ssj.png)

## Introduction

SSJ is a silly little script that makes use of [Docker](https://www.docker.com/) installed on your everyday Linux distribution (Ubuntu, Debian, etc.) and magically arms it with hundreds of penetration testing and forensic tools.

## Technical Details

SSJ pulls a Docker image that uses [Kali Linux](https://www.kali.org/) base image,`kalilinux/kali-last-release` with `kali-linux-default` metapackages installed over it. It uses the `kali.download/kali` mirror and `kali-last-snapshot` branch. With SSJ, you can run GUI applications like Burpsuite, Wireshark, Ettercap, etc. from within the container on your everyday Linux distribution, thanks to `--privileged` container capabilities and `xhost` universal access control. This script creates a `.desktop` file (the Application Launcher) for you that initiates the `docker run` command to run the container. So, the only thing you need to do is, find SSJ in your applicaiton drawer or menu and click on it to launch it. A `terminator` window will popup with all your pentesting and forensics tools in it. Execute `gui burpsuite` to fire up the proxy, `gui wireshark` to fire up the packet analyzer and like that, you have access to hundreds of tools and packages that are there in Kali Linux (particularly the `kali-linux-default` metapackages), right on your everyday Linux distribution. Also, contrary to virtual machines, that are either networked behind a virtual NAT or bridged along with the host operating system, SSJ utilizes the host network namespace as it is, using `--net=host`, which means that the SSJ container will have direct access to all the network interfaces as the host Linux distribution and will also share the same IP addresses.

## Prerequisites
+ Internet.
+ 15GB of disk space.
+ `git` & `iputils-ping` must be installed.
+ `docker` must be installed and the user must be present in the `docker` group.

## Installation

+ `curl -sL https://raw.githubusercontent.com/thirdbyte/ssj/main/install.sh | bash`

(This takes variable time depending upon your Internet speed. It pulls the Docker image from Docker Hub that weighs around 5GB.)

+ `sudo chown -R 0:0 $HOME/.ssj`

+ Reboot.

## Usage

1. Access the application drawer/menu on your Linux distribution to find SSJ.
2. Launch SSJ.
3. A `terminator` terminal will pop up.
4. Use this terminal to launch any tool by executing them using their respective package names. For an example: `msfconsole`, `gui burpsuite`, `gui wireshark`, etc.
5. You can save any file in the `/root/` directory inside the container and find it at `$HOME/.ssj` on your host Linux distribution.

## Screenshots

**Tested on:** Ubuntu 20.04.1 LTS (GNOME), Linux Mint 20 Ulyana (Cinnamon)

**Notice**: The screenshots underneath represent `xfce4-terminal` which is now replaced with `terminator`.

![Ubuntu Application Launcher](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_application_launcher.png)

![Ubuntu Burpsuite](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_burpsuite.png)

![Ubuntu Wireshark](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_wireshark.png)

![Ubuntu Ettercap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_ettercap.png)

![Ubuntu Metasploit & Nmap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/ubuntu_ssj_msf_nmap.png)

![Mint Application Launcher](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_application_launcher.png)

![Mint Burpsuite](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_burpsuite.png)

![Mint Wireshark](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_wireshark.png)

![Mint Ettercap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_ettercap.png)

![Mint Metasploit & Nmap](https://raw.githubusercontent.com/thirdbyte/ssj/main/screenshots/mint_ssj_msf_nmap.png)

## Plugins

+ [Add Tools](https://github.com/thirdbyte/ssj-plugin-add-tools): A convenient script that lets you add more tools to SSJ that are not a part of either the `kali-linux-default` metapackage.

## Updates

Since SSJ uses `kali-last-snapshot` branch of Kali Linux repositories, you don't need to update it until a new snapshot version (`2020.1`, `2020.2`, `2020.3`, etc.) of Kali Linux gets released. Once, a new version gets released, redo the [installation](https://github.com/thirdbyte/ssj#installation) and if you are using [Add Tools](https://github.com/thirdbyte/ssj-plugin-add-tools) plugin, you'll need to re-execute the `add-tools` script as well.

## Troubleshooting

+ Since the container runs with the root user privileges, the files created in the `/root` directory have the owner set to root. On the host Linux distribution, this directory is `$HOME/.ssj`. All the files and sub directories inside `$HOME/.ssj` will require the root user of the host Linux distribution in case any data needs to be written to or deleted from this directory.

## Limitations

+ SSJ uses Docker's `--privileged` container capabilities and `--net=host` networking. These are known to introduce security risks in production environments. SSJ also adds a universal access control to `xhost` for making GUI applications work, but immidiately closes it once SSJ's `terminator` is exited. This might allow any application to access the X server or GUI of your host Linux distribution in particular for the time SSJ is running which can be a security or a privacy concern for many.
+ Audio input/ouput does not work as of now.
+ SSJ is a preconfigured & immutable toolkit, which means that any changes made to the filesystem (except `/root/`) will not persist. For creating mutable & customized containers, check out [kalidock](https://github.com/thirdbyte/kalidock).

## Uninstallation

1. `curl -sL https://raw.githubusercontent.com/thirdbyte/ssj/main/uninstall.sh | bash`
2. `sudo rm -rf $HOME/.ssj/`

## And...

This script was created out of curiosity. This might solve a lot of problems. This might create new ones as well. It comes with no commitments whatsoever. You may do anything you wish to do with this script and are solely responsible for it. You can still feel free to file issues in case you experience any of them. Cheers!
