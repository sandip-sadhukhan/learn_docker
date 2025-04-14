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

## Sharing Images & Containers
Everyone who has an image, can create containers based on the image!

### Share a Dockerfile
Simply run `docker build .`

IMPORTANT: The Dockerfile instructions might need surrounding files/folders (e.g. source code)

### Share a Built Image
Download an image, run a container based on it. No build step required, everything is included in the image already!


### Sharing via DockerHub or Private Registry

```bash
docker push IMAGE_NAME
docker pull IMAGE_NAME
```

`IMAGE_NAME` needs to be `HOST:NAME` to talk to private registry.

Create new image with updated tag so that we can push it to `DockerHub`.

```bash
docker tag basicnodejsapp:latest sandipsadhukhan/nodejs-app:latest
```

## Docker volumes
Volumes are folders on your host machine hard drive which are mounted ("made available", mapped)
into containers.

-> Volume persist if a container shuts down. If a container (re-)starts and mounts
a volume, any data inside of that volume is available in the container.
-> A container can write data into a volume and read data from it.

### Types of volumes
1. Anonymous Volume: Only exist as long as the container exist. eg: `VOLUME ["/app/feedback"]`
2. Named Volume: It will exist even after container removed.

Docker sets up a folder / path on your host machine, exact location is unknown
to you as a dev. Managed via `docker volume` commands.

### Creating named volume
```bash
docker run -d -p 3000:80 --rm --name feedback-app -v feedback:/app/feedback feedback-node:volumes
```
Here `feedback` is the name of the volume and path is container's `/app/feedback` folder

## Bind Mounts (managed by us)
We define a folder / path on our host machine.
We need to add access to the folder to Docker(using docker desktop resources -> file sharing option)
So that docker can bind folder.

```bash
docker run -d -p 3000:80 --rm --name feedback-app -v /Users/sandip/coding/docker-notes/3-section/node_app1:/app feedback-node:volumes
```

```bash
# Anonymous volume
docker run -v /app/data ...

# Named volume
docker run -v data:/app/data ...

# Bind Mount
docker run -v /path/to/code:/app/code ...
```

For Bind mount, by default container can read & write volumes. If we only want
docker container to read only into local file system then you can use `:ro`
```bash
docker run -v /path/to/code:/app/code:ro ...
```

### Create volume manually
```bash
docker volume create feedback-files

# Then use it
docker run -v feedback-files:/app/code
```

## `.dockerignore` file
When we do copy for example `COPY . .`, then it will copy all files, but if we
don't want to copy certain files/folders, then we can write that inside `.dockerignore` file

## Environments variables
We can set Environment variable in `Dockerfile` like `ENV PORT 80` then in your
application code you can use it like for nodejs `process.env.PORT`.
And you can override this port from docker run command as well
`docker run -e PORT=8000 ....`

Or can create a `.env` file and write
```
PORT=8000
```
Then instead of `-e` argument you can use
`docker run --env-file ./.env ...`

## Build time arguments
When we build the image we can pass some arguments. In `Dockerfile`
```Dockerfile
ARG DEFAULT_PORT=80

ENV PORT $DEFAULT_PORT

EXPOSE $PORT
```

We can build 2 images one with default port 80 and another one with default port 8000
```bash
docker build -t feedback-node:web-app .

docker build -t feedback-node:dev --build-arg DEFAULT_PORT=8000 .
```
