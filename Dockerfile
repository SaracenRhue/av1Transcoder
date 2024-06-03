# Use NVIDIA CUDA base image
FROM nvidia/cuda:12.3.1-runtime-ubuntu20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
# ENV NVIDIA_VISIBLE_DEVICES=GPU-b39df49c-2a34-29f1-d932-b57c615d22eb
ENV INPUT_DIR=/data
  
# Set working directory
WORKDIR /app

# Install Python, pip, and other dependencies in a single RUN command to reduce layers
RUN apt update && \
    apt install -y ffmpeg git build-essential cmake && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy project files
COPY transcode.sh /usr/local/bin/transcode.sh
RUN chmod +x /usr/local/bin/transcode.sh

VOLUME [ "/data" ]

CMD [ "/usr/local/bin/transcode.sh" ]
