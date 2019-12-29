FROM ubuntu:18.04
RUN apt-get update
RUN apt-get -y install git make gdb seabios libbsd-dev gcc-multilib \
	libc6-dev linux-libc-dev qemu-system-x86 python3-dev
COPY ./jos /jos
WORKDIR /jos
