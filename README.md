# hlsbox
Minimal RTMP to HLS solution in Docker. Built with static nginx and ffmpeg binaries to minimize image size.

## Install

```
docker pull ziyan/hlsbox:latest
```

## Run

```
mkdir data
chown www-data:www-data data

docker run -p 1935:1935 -v $(pwd)/data:/data ziyan/hlsbox:latest
```

## Build

```
make
```
