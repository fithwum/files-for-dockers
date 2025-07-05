FROM debian:bullseye

ARG VERSION
ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /builder

RUN apt-get update && apt-get install -y \
    debootstrap wget curl bash ftp-upload dirmngr locales sudo git \
    && apt-get clean

# Setup locale
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

COPY base-image-script/ base-image-script/

RUN chmod +x base-image-script/*.sh

# Default command overridden by workflow
CMD ["bash"]
