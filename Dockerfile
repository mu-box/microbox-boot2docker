FROM boot2docker/boot2docker:19.03.5

ENV TCL_REPO_BASE   http://tinycorelinux.net/10.x/x86_64
# Note that the ncurses is here explicitly so that top continues to work
ENV MICRO_DEPS libcap coreutils samba-libs cifs-utils

RUN set -ex && \
    for dep in $MICRO_DEPS; do \
        echo "Download $TCL_REPO_BASE/tcz/$dep.tcz"; \
        wget -O /tmp/$dep.tcz $TCL_REPO_BASE/tcz/$dep.tcz; \
    unsquashfs -f -d /rootfs /tmp/$dep.tcz; \
        rm -f /tmp/$dep.tcz; \
    done

RUN make-b2d-iso.sh

CMD ["cat", "/tmp/boot2docker.iso"]
