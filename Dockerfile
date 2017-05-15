FROM nvidia/cuda:8.0-devel-ubuntu14.04

RUN apt-get -y update && apt-get install -y wget nano git build-essential yasm pkg-config

RUN git clone https://github.com/FFmpeg/FFmpeg /root/ffmpeg && \
  cd /root/ffmpeg && ./configure \
  --enable-nonfree --disable-shared \
  --enable-nvenc --enable-cuda \
  --enable-cuvid --enable-libnpp \
  --extra-cflags=-I/usr/local/cuda/include \
  --extra-cflags=-I/usr/local/include \
  --extra-ldflags=-L/usr/local/cuda/lib64 && \
  make -j8 && \
  make install -j8 && \
  cd /root && rm -rf ffmpeg

WORKDIR /root
