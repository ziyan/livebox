# livebox
Minimal RTMP to HLS solution in Docker. Built with static nginx and ffmpeg binaries to minimize image size.

## Install

```
docker pull ziyan/livebox:latest
```

## Run

```
mkdir data
chown www-data:www-data data
```

```
docker run -p 1935:1935 -v $(pwd)/data:/data ziyan/livebox:latest
```

```
ffmpeg -re -i input.flv -c copy -f flv rtmp://localhost/live/livestream
```

## Build

```
make
```
