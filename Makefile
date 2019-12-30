GDBPORT	:= $(shell expr `id -u` % 5000 + 25000)
GDBSERV := jos:$(GDBPORT)

net:
	docker network create --driver=bridge jos-net

build:
	docker build -t jos-env .

gdb: build
	docker container run -it --rm --net=jos-net --name=gdb jos-env $(MAKE) gdb GDBSERV=$(GDBSERV)

grade: build
	docker container run -it --rm jos-env $(MAKE) grade

qemu: build
	docker container run -it --rm jos-env $(MAKE) qemu

qemu-nox: build
	docker container run -it --rm jos-env $(MAKE) qemu-nox

qemu-gdb: build
	docker container run -it --rm --net=jos-net --name=jos jos-env $(MAKE) qemu-gdb GDBSERV=0.0.0.0:$(GDBPORT)

qemu-nox-gdb: build
	docker container run -it --rm --net=jos-net --name=jos jos-env $(MAKE) qemu-nox-gdb GDBSERV=0.0.0.0:$(GDBPORT)

run-%: build
	docker container run -it --rm jos-env $(MAKE) $@

run-%-nox: build
	docker container run -it --rm jos-env $(MAKE) $@

run-%-gdb: build
	docker container run -it --rm --net=jos-net --name=jos jos-env $(MAKE) $@ GDBSERV=0.0.0.0:$(GDBPORT)

run-%-nox-gdb: build
	docker container run -it --rm --net=jos-net --name=jos jos-env $(MAKE) $@ GDBSERV=0.0.0.0:$(GDBPORT)

.PHONY: build grade net qemu qemu-nox
