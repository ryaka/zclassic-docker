FROM debian:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  pkg-config \
  libc6-dev \
  m4 \
  g++-multilib \
  autoconf \
  libtool \
  ncurses-dev \
  unzip \
  git \
  python \
  zlib1g-dev \
  wget \
  bsdmainutils \
  automake

# Clone github repository
RUN git clone git://github.com/z-classic/zclassic.git

# Navigate to directory and build binary
WORKDIR /zclassic
RUN ./zcutil/build.sh -j$(nproc)
RUN ./zcutil/fetch-params.sh

# Set up configurations for node
COPY ./zclassic.template.conf /root/.zclassic/zclassic.conf
# Generate super secret rpc user and password
RUN echo "rpcuser=`head -c 16 /dev/urandom | base64`" >> /root/.zclassic/zclassic.conf
RUN echo "rpcpassword=`head -c 64 /dev/urandom | base64`" >> /root/.zclassic/zclassic.conf

# Copy binaries to system path
RUN cp /zclassic/src/zcashd /usr/bin
RUN cp /zclassic/src/zcash-cli /usr/bin

# Run the zclassic node
ENTRYPOINT ["zcashd"]
