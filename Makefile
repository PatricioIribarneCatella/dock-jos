GDBPORT	:= $(shell expr `id -u` % 5000 + 25000)

build:
	docker build -t jos-env .

gdb: build
	docker container run -it --rm -p $(GDBPORT):$(GDBPORT) jos-env $(MAKE) gdb GDBPORT=$(GDBPORT)

grade: build
	docker container run -it --rm jos-env $(MAKE) grade

qemu: build
	docker container run -it --rm jos-env $(MAKE) qemu

qemu-nox: build
	docker container run -it --rm jos-env $(MAKE) qemu-nox

qemu-gdb: build
	docker container run -it --rm -p $(GDBPORT):$(GDBPORT) jos-env $(MAKE) qemu-gdb GDBPORT=$(GDBPORT)

qemu-nox-gdb: build
	docker container run -it --rm -p $(GDBPORT):$(GDBPORT) jos-env $(MAKE) qemu-nox-gdb GDBPORT=$(GDBPORT)

run-%: build
	docker container run -it --rm jos-env $(MAKE) $@

run-%-nox: build
	docker container run -it --rm jos-env $(MAKE) $@

run-%-gdb: build
	docker container run -it --rm -p $(GDBPORT):$(GDBPORT) jos-env $(MAKE) $@ GDBPORT=$(GDBPORT)

run-%-nox-gdb: build
	docker container run -it --rm -p $(GDBPORT):$(GDBPORT) jos-env $(MAKE) $@ GDBPORT=$(GDBPORT)

.PHONY: build grade qemu qemu-nox
