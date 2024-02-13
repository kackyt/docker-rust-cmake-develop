FROM rust:slim-bookworm

ARG TARGETARCH
ENV APP_PATH /opt/apps
ENV HOME /home/app
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends cmake build-essential gdb nano strace libssl-dev pkg-config
RUN if [ "${TARGETARCH}" = "amd64" ]; then apt-get install -y --no-install-recommends libc6-dev-i386 gcc-multilib && rustup target add i686-unknown-linux-gnu; fi
RUN groupadd -r app && useradd -r -g app app

USER app
WORKDIR ${HOME}

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["/bin/bash"]
