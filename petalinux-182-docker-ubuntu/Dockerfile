FROM ubuntu:16.04

LABEL maintainer="ahe@xilinx.com"

#ENV http_proxy=http://172.20.201.1:8080 https_proxy=http://172.20.201.1:8080
#ENV http_proxy=http://proxy:8080 https_proxy=http://proxy:8080
ENV HTTP_PROXY "http://proxy:8080"
ENV HTTPS_PROXY "https://proxy:8080"

ARG version=2018.2
ARG date_created=1110
#ARG plnx_bsps_dir=petalinux-v${version}_bsps_${date_created}_1
#ARG plnx_dir=petalinux-v${version}_${date_created}_1
ARG plnx_bsps_dir=petalinux-v${version}_bsps
ARG plnx_dir=petalinux-v${version}
ARG user=plnx_user
ARG group=random

RUN dpkg --add-architecture i386

RUN apt-get update -y && apt-get clean all

RUN apt-get install -y sudo iputils-ping

RUN echo "%sudo ALL=(ALL:ALL) ALL" >> /etc/sudoers

RUN echo "%sudo ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#RUN yum install -y glibc-devel-2.17-157.el7_3.4.x86_64 && yum install -y dos2unix iproute-3.10.0-74.el7.x86_64 gawk-4.0.2-4.el7.x86_64 gcc-4.8.5-11.el7.x86_64 git-1.8.3.1-6.el7_2.1.x86_64 make-3.82-23.el7.x86_64 ncurses-devel-5.9-13.20130511.el7.x86_64 zlib-devel-1.2.7-17.el7.x86_64 flex-2.5.37-3.el7.x86_64 bison-2.7-4.el7.x86_64 libselinux-2.5-6.el7.x86_64 wget-1.14-13.el7.x86_64 diffstat-1.57-4.el7.x86_64 chrpath-0.13-14.el7.x86_64 socat-1.7.2.2-5.el7.x86_64 xterm-295-3.el7.x86_64 autoconf-2.69-11.el7.noarch libtool-2.4.2-21.el7_2.x86_64 tar-1.26-31.el7.x86_64 unzip-6.0-16.el7.x86_64 texinfo-5.1-4.el7.x86_64 SDL-devel-1.2.15-14.el7.x86_64  glib2-devel-2.46.2-4.el7.x86_64 openssl-devel-1.0.1e-60.el7.x86_64 automake-1.13.4-3.el7.noarch gzip-1.5-8.el7.x86_64 libz.so.1 libstdc++-4.8.5-11.el7.x86_64 zlib-1.2.7-17.el7.x86_64 bzip2-devel sqlite-devel python34.x86_64 perl-CPAN expect patch file bzip2 gcc-c++ tftp-server redhat-lsb-core-4.1-27.el7.centos.1.x86_64 xorg-x11-utils xorg-x11-server-Xvfb texinfo net-tools-2.0-0.17.20131004git.el7.x86_64 screen python-xvfbwrapper pax which libstdc++.i686 libgcc.i686

RUN apt-get install -y tofrodos iproute2 gawk xvfb gcc-4.8 wget build-essential checkinstall libreadline-gplv2-dev \
	libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev git make net-tools libncurses5-dev \
	tftpd zlib1g-dev libssl-dev flex bison libselinux1 gnupg diffstat chrpath socat xterm autoconf libtool tar unzip texinfo \
	gcc-multilib libsdl1.2-dev libglib2.0-dev screen pax gzip language-pack-en libtool-bin cpio lib32z1 lsb-release zlib1g:i386 \
	vim-common libgtk2.0-dev libstdc++6:i386 libc6:i386

RUN cd /usr/src && wget https://www.python.org/ftp/python/3.4.5/Python-3.4.5.tgz && tar xzf Python-3.4.5.tgz && rm -f Python-3.4.5.tgz \
	&& cd Python-3.4.5 && ./configure && make altinstall

RUN mkdir -p /proj/petalinux /tools/xgs/perl /proj/petalinux/$plnx_dir /proj/petalinux/$plnx_bsps_dir

ADD plnx_installer.pl /proj/petalinux/$plnx_dir

ADD default.env /tmp

RUN wget -O - http://cpanmin.us | perl - App::cpanminus

ADD File-Tail-1.3.tar.gz /tmp

RUN cd /tmp/File-Tail-1.3 && perl Makefile.PL && make && make test && make install && cpanm Expect && rm -rf /tmp/File-Tail-1.3

ADD $plnx_bsps_dir /proj/petalinux/$plnx_bsps_dir

ADD $plnx_dir /proj/petalinux/$plnx_dir

RUN groupadd $group && useradd -G $group $user && mkdir -p /home/$user && cd /home/ && chown -R $user:$user $user \
	&& locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales && locale-gen "en_US.UTF-8"

RUN chown -R $user:$group /proj

USER $user

ENV LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8

WORKDIR /proj/petalinux/$plnx_dir/

RUN perl /proj/petalinux/$plnx_dir/plnx_installer.pl

RUN echo "source /proj/petalinux/${plnx_dir}/settings.sh" >> ~/.bashrc

#RUN /bin/bash -c "source settings.sh; cd /proj/petalinux/$plnx_bsps_dir; petalinux-create --template zynqMP -t project -s xilinx-zcu102-v${version}-final.bsp"

#WORKDIR /proj/petalinux/$plnx_bsps_dir/

USER root


# sudo docker build ./ --network=host --build-arg version=2018.2 --build-arg date_created=1110 -t petalinux-182-ubuntu:test
