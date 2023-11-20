#!/bin/sh

# Check if input and output directories are set
if [ -z "$INPUT_DIR" ] || [ -z "$OUTPUT_DIR" ]; then
  echo "Input or output directory not set. Exiting."
  exit 1
fi

# Transcoding command using FFmpeg and GNU Parallel
parallel --eta -j 75% ffmpeg -i {} -c:v libaom-av1 -crf 18 -cpu-used 0 -pass 1 -f null /dev/null \; ffmpeg -i {} -c:v libaom-av1 -crf 18 -cpu-used 0 -pass 2 $OUTPUT_DIR/{/.}.mkv ::: $INPUT_DIR/*.mp4
