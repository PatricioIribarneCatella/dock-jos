FROM ubuntu:18.04

RUN apt-get update && apt-get -y install \
	git make gdb python3-dev wget \
	libbsd-dev libc6-dev gcc-multilib linux-libc-dev \
	seabios qemu-system-x86

RUN wget http://launchpadlibrarian.net/508305356/qemu-system-x86_2.11+dfsg-1ubuntu7.34_amd64.deb && \
	dpkg -i qemu-system-x86_2.11+dfsg-1ubuntu7.34_amd64.deb && \
	rm qemu-system-x86_2.11+dfsg-1ubuntu7.34_amd64.deb

COPY ./jos /jos

WORKDIR /jos
