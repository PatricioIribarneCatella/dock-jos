# docker-jos

_Dockerfile_ and _Makefile_ for running _JOS_ and its dependencies in a [_Docker_](https://docs.docker.com/install/linux/docker-ce/ubuntu/) container.

## Initialize

You will have to change a little bit the _Makefile_ that comes with _JOS_ in the target `gdb`, like this:

- Original

```make
gdb:
```

- Changed

```make
gdb: $(IMAGES)
```

In this way, the container running the _GDB_ session, compiles the files and produces the necessary binaries for _GDB_ to read the symbols from.

Finally you will need to create a _docker network_ for the containers to communicate among them, like this:

```bash
$ make net
```

## Running

You can use different _ubuntu_ versions (16.04, 18.04 and 20.04) just by setting up the variable `DOCKBASEIMG` to the major number of them (i.e. `DOCKBASEIMG=16`). By default the **18** is used.

- ***Grade***

```bash
$ make grade
```

- ***Run a program***

	- Graphical

    ```bash
    $ make run-%
    ```

	- Non Interactive

    ```bash
    $ make run-%-nox
    ```

- ***QEMU***

	- Graphical

    ```bash
    $ make qemu
    ```

	- Non Interactive

    ```bash
    $ make qemu-nox
    ```

- ***GDB***

If you want to run a _GDB_ session you will need two terminals as in the normal way, an run the commands you will run with the non containerazed version.

