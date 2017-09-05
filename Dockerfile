FROM ubuntu:14.04
MAINTAINER Marc Bachmann <marc.brookman@gmail.com>

ENV LIBVIPS_VERSION_MAJOR 8
ENV LIBVIPS_VERSION_MINOR 4
ENV LIBVIPS_VERSION_PATCH 1
ENV LIBVIPS_VERSION $LIBVIPS_VERSION_MAJOR.$LIBVIPS_VERSION_MINOR.$LIBVIPS_VERSION_PATCH

RUN \

  # Install dependencies
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
  automake build-essential curl autoconf libtool pkg-config \ 
  zlib1g-dev libsqlite3-dev libcairo2-dev libgtk2.0-dev \
  gobject-introspection gtk-doc-tools libglib2.0-dev libopenjpeg-dev libjpeg-turbo8-dev \
  libpng12-dev libwebp-dev libtiff5-dev libgif-dev libexif-dev libxml2-dev \
  libpoppler-glib-dev swig libmagickwand-dev libpango1.0-dev libmatio-dev libcfitsio3-dev git \
  libgsf-1-dev fftw3-dev liborc-0.4-dev librsvg2-dev

RUN \

  # Build openslide
  cd /tmp && \
  git clone https://github.com/openslide/openslide.git && cd openslide && \
  autoreconf -i && ./configure && \
  make && make install

RUN \

  # Build libvips
  cd /tmp && \
  git clone https://github.com/jcupitt/libvips.git && cd libvips && \
  ./autogen.sh && \
  make && \
  make install && \
  ldconfig 

RUN \

  # Clean up
  apt-get remove -y curl automake build-essential && \
  apt-get autoremove -y && \
  apt-get autoclean && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
