FROM debian:10

ENV container docker
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive

# install systemd and SSH

RUN apt-get update \
    && apt-get install -y \
        systemd systemd-sysv \
        net-tools \
        openssh-server \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && rm -f /lib/systemd/system/multi-user.target.wants/* \
             /etc/systemd/system/*.wants/* \
             /lib/systemd/system/local-fs.target.wants/* \
             /lib/systemd/system/sockets.target.wants/*udev* \
             /lib/systemd/system/sockets.target.wants/*initctl* \
             /lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \
             /lib/systemd/system/systemd-update-utmp*


COPY key.pub /root/.ssh/authorized_keys

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/lib/systemd/systemd"]
