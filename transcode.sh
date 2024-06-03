#!/bin/bash
# transcode.sh - Transcode videos in parallel

# Function to transcode a single video file
transcode_video() {
    local input="$1"
    local output="${input%.*}.mp4"

    # Transcoding command (adjust according to your needs, example uses CPU-based AV1 encoding)
    ffmpeg -i "$input" -c:v libaom-av1 -crf 30 -b:v 0 -c:a copy "$output" && mv "$output" "$input"
}

export -f transcode_video

# Find all video files in $INPUT_DIR and transcode them in parallel
find "$INPUT_DIR" -type f \( -name "*.mp4" -or -name "*.mkv" \) -print0 | xargs -0 -n1 -P4 -I{} bash -c 'transcode_video "$@"' _ {}
