build:
	docker build -t jos-env .

qemu: build
	docker container run -it --rm jos-env $(MAKE) qemu

qemu-nox: build
	docker container run -it --rm jos-env $(MAKE) qemu-nox

grade: build
	docker container run -it --rm jos-env $(MAKE) grade

run-%-nox: build
	docker container run -it --rm jos-env $(MAKE) $@

run-%: build
	docker container run -it --rm jos-env $(MAKE) $@

.PHONY: build grade qemu qemu-nox
