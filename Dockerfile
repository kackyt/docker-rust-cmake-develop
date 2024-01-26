FROM rust:slim-bookworm

ARG TARGETARCH
ENV APP_PATH /opt/apps
ENV HOME /home/app
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends cmake build-essential gdb nano strace
RUN if [ "${TARGETARCH}" = "amd64" ]; then apt-get install -y --no-install-recommends libc6-dev-i386 gcc-multilib libssl-dev && rustup target add i686-unknown-linux-gnu; fi
RUN groupadd -r app && useradd -r -g app app
RUN mkdir ${HOME}
COPY . ${APP_PATH}
WORKDIR ${APP_PATH}

RUN chown app:app ${APP_PATH} -R
RUN chown app:app ${HOME} -R

USER app

ENTRYPOINT [ "/bin/sh", "-c" ]
CMD ["/bin/bash"]
