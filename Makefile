GDBPORT	:= $(shell expr `id -u` % 5000 + 25000)

DOCKER := docker
DOCKRUN := container run
DOCKBUILD := build
DOCKNETWORK := network create
DOCKOPTS := -it --rm
DOCKOPTSGDB := --net=jos-net
DOCKIMG := jos-env
DOCKNET := jos-net
DOCKBASEIMG := 18

net:
	$(DOCKER) $(DOCKNETWORK) --driver=bridge $(DOCKNET)

build:
	$(DOCKER) $(DOCKBUILD) -t $(DOCKIMG) -f dockerfiles/Dockerfile-$(DOCKBASEIMG).04 .

gdb: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKOPTSGDB) --name=gdb $(DOCKIMG) $(MAKE) gdb GDBSERV=jos:$(GDBPORT)

grade: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKIMG) $(MAKE) grade

qemu: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKIMG) $(MAKE) qemu

qemu-nox: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKIMG) $(MAKE) qemu-nox

qemu-gdb: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKOPTSGDB) --name=jos $(DOCKIMG) $(MAKE) qemu-gdb GDBSERV=0.0.0.0:$(GDBPORT)

qemu-nox-gdb: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKOPTSGDB) --name=jos $(DOCKIMG) $(MAKE) qemu-nox-gdb GDBSERV=0.0.0.0:$(GDBPORT)

run-%: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKIMG) $(MAKE) $@

run-%-nox: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKIMG) $(MAKE) $@

run-%-gdb: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKOPTSGDB) --name=jos $(DOCKIMG) $(MAKE) $@ GDBSERV=0.0.0.0:$(GDBPORT)

run-%-nox-gdb: build
	$(DOCKER) $(DOCKRUN) $(DOCKOPTS) $(DOCKOPTSGDB) --name=jos $(DOCKIMG) $(MAKE) $@ GDBSERV=0.0.0.0:$(GDBPORT)

.PHONY: net build gdb grade qemu qemu-nox qemu-gdb
