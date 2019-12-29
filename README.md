# docker-jos

_Dockerfile_ and _Makefile_ for running _JOS_ and its dependencies in a [_Docker_](https://docs.docker.com/install/linux/docker-ce/ubuntu/) container.

- Grade

```bash
$ make grade
```

- Run a program

	- Graphical

    ```bash
    $ make run-%
    ```

	- Non Interactive

    ```bash
    $ make run-%-nox
    ```

- QEMU

	- Graphical

    ```bash
    $ make qemu
    ```

	- Non Interactive

    ```bash
    $ make qemu-nox
    ```

