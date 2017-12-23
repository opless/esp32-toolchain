FROM ubuntu:16.04

# Install build dependencies (and vim + picocom for editing/debugging)
RUN apt-get -qq update \
    && apt-get install -y git wget make libncurses-dev flex bison gperf python python-serial vim picocom screen \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Create some directories, and grab the ESP32 toolchain
RUN \
mkdir -p /esp /esp/project && \
wget -O /esp/toolchain.tgz https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-75-gbaf03c2-5.2.0.tar.gz && \
cd /esp && \
tar xvf /esp/toolchain.tgz &&  \
rm /esp/toolchain.tgz && \
git clone --recursive https://github.com/espressif/esp-idf.git


# Add the toolchain binaries to PATH
ENV PATH /esp/xtensa-esp32-elf/bin:$PATH

# Setup IDF_PATH
ENV IDF_PATH /esp/esp-idf

# This is the directory where our project will show up
WORKDIR /esp/project
