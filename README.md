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

## Run with std input open
```bash
docker run -it <image_id>
```

Or restart with attached and interactive mode

```
docker start -ai <container_id>
```

## Remove a docker container
```
docker rm <container_id/name>
```

## Remove a docker image
```
docker rmi <image_id>
```

## When container stop, then remove the container automatically

```
docker run --rm <container_id>
```

## Check info about a image
```
docker inspect <image_id>
```

## Copy files b/w local computer & docker container

Copy from local computer to docker container
```
docker cp dummy/. adf113dec06e:/test
```

it will copy all files under `dummy` folder exist on local computer into the container id `adf113dec06e`s' test folder.
It will create `test` folder if not exist.

Copy from docker container to local computer
```
docker cp adf113dec06e:/test dummy
```

## How to add name to docker container
By default docker add some random name into container. But we can specify name
during creating the container by `--name` attribute.
```bash
docker run -p 3000:80 -d --rm --name goalsapp <image_id>
```
Now we can use container name instead of id which is easy to work with like
```bash
docker stop goalsapp
```

## What is image tag?
`name:tag`

name: Defines a group of possible more specialized, images. Example: "node"
tag: Defines a specialized image within a group of images. Example: "14"

We can add name and tag to image by the following command:
```bash
docker build -t goals:latest .
```
Here `goals` is name of the image and `latest` is the tag.

Now we can create container on a specific tag of a image also.

```bash
docker run -p 3000:80 -d --rm --name goalsapp goals:latest
```
