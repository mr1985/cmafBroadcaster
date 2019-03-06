#!/bin/bash
# Encoding settings for x264 (CPU based encoder)

/ffmpeg/ffmpeg \
  -re -stream_loop -1  \
  -hide_banner -y \
  -i /tmp/playlists/playlist_url.txt \
  -vf "fps=30,drawtext=fontfile=/tmp/utils/OpenSans-Bold.ttf:box=1:fontcolor=black:boxcolor=white:fontsize=100':x=40:y=400:textfile=/tmp/utils/text.txt" \
  -protocol_whitelist file,http,https,tcp,tls \
  -utc_timing_url "https://time.akamai.com/?iso" \
  -f hls -master_pl_name $OUTPUT_FOLDER/master.m3u8 \
  -flags +cgop -g 60 -keyint_min 60 -hls_time 2  \
  -segment_list_flags +live \
  -hls_flags delete_segments \
  -c:v libx264 -tune zerolatency -preset ultrafast  -b:v:0 300k  -s:v:0  320x240  -b:v:1 500k  -s:v:1  640x360 -b:v:2 1000k -s:v:2 1280x720 \
  -c:a aac -b:a:0 48k -b:a:1 96k -b:a:2 128k \
  -map 0:v -map 0:a -map 0:v -map 0:a -map 0:v -map 0:a \
  -var_stream_map "v:0,a:0, v:1,a:1 v:2,a:2" \
   index_%v_.m3u8
   #>/dev/null 2>logs/encode.log &
    
