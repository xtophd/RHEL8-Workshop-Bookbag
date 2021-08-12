FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

USER root

RUN mkdir -p ./workshop/content/documentation && \
    git clone -b summit-2021-dev https://github.com/xtophd/RHEL8-Workshop /tmp/RHEL8-Workshop && \
    cp -vR /tmp/RHEL8-Workshop/documentation/_include/* ./workshop/content/documentation

COPY . /tmp/src

RUN rm -rf /tmp/src/.git* && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && \
    chmod -R g+w /tmp/src

USER 1001

RUN /usr/libexec/s2i/assemble
