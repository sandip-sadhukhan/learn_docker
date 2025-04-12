# Commands

## Build a docker image
```bash
docker build .
```

## Run the docker image
```bash
docker run <container_id>
```

## Run a interactive shell session
```bash
docker run -it node
```

## Difference b/w `RUN` and `CMD`?
`RUN` will run during docker image build, and `CMD` will run when container is started.

## Run in detachment mode
When you run a long running docker run command like `docker run -p 8000:80 <image_id>`
Then it will execute the program but you can't use that terminal.
We can solve this by running the command in detach mode

```bash
docker run -p 8000:80 -d <image_id>
```

If we want to attach again with that container then we can use `attach` command
```bash
docker attach <container_name>
```

We can see logs by `docker logs <container_name>`