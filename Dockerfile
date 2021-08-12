FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

USER root

COPY . /tmp/src

RUN mkdir -p /tmp/src/workshop/content/documentation 
RUN git clone --depth 1 -b summit-2021-dev https://github.com/xtophd/RHEL8-Workshop /tmp/RHEL8-Workshop 
RUN cp -vR /tmp/RHEL8-Workshop/documentation/_include/* /tmp/src/workshop/content/documentation 
RUN ls -lR /tmp/src/workshop 

RUN rm -rf /tmp/src/.git*  && \
    chown -R 1001 /tmp/src && \
    chgrp -R 0 /tmp/src && && \
    chmod -R g+w /tmp/src 

USER 1001

RUN /usr/libexec/s2i/assemble
