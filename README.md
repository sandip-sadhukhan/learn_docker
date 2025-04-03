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
