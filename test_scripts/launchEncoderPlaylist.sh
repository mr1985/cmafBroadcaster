#!/bin/bash
# Encoding settings for x264 (CPU based encoder)

x264enc='h264_nvenc -profile:v high -bf 0 -refs 3 -sc_threshold 0'

ffmpeg \
    -hide_banner \
    -re \
    -protocol_whitelist file,http,https,tcp,tls \
    -i BigBuckBunny.mp4 \
    -pix_fmt yuv420p \
    -map 0:v \
    -c:v h264_nvenc -profile:v high -bf 0 -refs 3 -sc_threshold 0 \
    -g 150 \
    -keyint_min 150 \
    -b:v 2000k \
    -seg_duration 3 \
    -streaming 1 \
    -utc_timing_url "https://time.akamai.com/?iso" \
    -index_correction 1 \
    -use_timeline 0 \
    -media_seg_name 'chunk-stream-$RepresentationID$-$Number%05d$.m4s' \
    -init_seg_name 'init-stream1-$RepresentationID$.m4s' \
    -window_size 5  \
    -extra_window_size 10 \
    -remove_at_exit 1 \
    -adaptation_sets "id=0,streams=v" \
    -f dash \    
    $OUTPUT_FOLDER/manifest.mpd
    #>/dev/null 2>logs/encode.log &
