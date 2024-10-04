FROM fedora:40

COPY wsl.conf /etc/wsl.conf
COPY bash_profile /root/.bash_profile

COPY config /var/config

RUN rm -f /etc/yum.repos.d/fedora-cisco-openh264.repo

RUN sed -e 's|^metalink=|#metalink=|g' \
         -e 's|^#baseurl=http://download.example/pub/fedora/linux|baseurl=https://mirrors.cernet.edu.cn/fedora|g' \
         -i.bak \
         /etc/yum.repos.d/*.repo

RUN dnf update -y
RUN dnf install -y bsdtar basesystem dnf-plugins-core iputils sudo wget which zip ripgrep fd-find fish lsd emacs-nw git git-core gcc ncurses rpmdevtools rpmlint
RUN dnf copr enable wslutilities/wslu -y
RUN dnf install -y wslu

RUN dnf clean all; pwconv; grpconv

