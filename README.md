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

## Configurations
These settings should be passed in to docker using ```-e "KEY=VALUE"``` arguments. Or, see example for how to use them in ```docker-compose.yml```.

- HLS settings
  - ```HLS_LIST_SIZE=10``` How many segments should be kept in the m3u8 live playlist
  - ```HLS_TIME=4``` How long each segment should be in seconds

- Substreams declaration
  - ```SUBSTREAMS=720p 540p 360p 216p``` Name of substreams seperated by space.

  - 720p settings
    - ```SUBSTREAM_720p_BITRATE=4252000``` Total bitrate of a substream, video and audio
    - ```SUBSTREAM_720p_VIDEO_SIZE=1280x720``` Resolution of video
    - ```SUBSTREAM_720p_VIDEO_FPS=25``` Frame rat eof video

  - 540p settings
    - ```SUBSTREAM_540p_BITRATE=2377000```
    - ```SUBSTREAM_540p_VIDEO_SIZE=960x540```
    - ```SUBSTREAM_540p_VIDEO_FPS=25```

  - 360p settings
    - ```SUBSTREAM_360p_BITRATE=1063000```
    - ```SUBSTREAM_360p_VIDEO_SIZE=640x360```
    - ```SUBSTREAM_360p_VIDEO_FPS=25```

  - 216p settings
    - ```SUBSTREAM_216p_BITRATE=420000```
    - ```SUBSTREAM_216p_VIDEO_SIZE=384x216```
    - ```SUBSTREAM_216p_VIDEO_FPS=25```

- Video codec settings
  - ```VIDEO_PROFILE=baseline```
  - ```VIDEO_LEVEL=3.1```

- Audio codec settings
  - ```AUDIO_SAMPLING_RATE=44100```
  - ```AUDIO_CHANNELS=2```
  - ```AUDIO_BITRATE=96k```

## Build

```
make
```
