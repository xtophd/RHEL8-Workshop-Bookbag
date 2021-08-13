FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

ENV GIT_REPO=https://github.com/xtophd
ENV GIT_PRJ=RHEL8-Workshop
ENV GIT_REF=summit-2021-dev

ENV APP_ROOT=/tmp/src

ENV DOC_SRC=${GIT_TMP}/documentation/_include
ENV DOC_DST=${APP_ROOT}/workshop/content/documentation

USER root

## Trying  solution found here: https://github.com/moby/moby/issues/14704

COPY . ${APP_ROOT}

ADD ${GIT_REPO}/${GIT_PRJ}/archive/${GIT_REF}.tar.gz /tmp/${GIT_PRJ}-${GIT_REF}.tar.gz

RUN  pwd ;\
     ls -l /tmp/${GIT_PRJ}-${GIT_REF}.tar.gz ;\
     cd ${APP_ROOT} ;\
     tar xvfz /tmp/${GIT_PRJ}-${GIT_REF}.tar.gz 

RUN  rm -rf ${GIT_TMP}         && \
     rm -rf ${APP_ROOT}/.git*  && \
     chown -R 1001 ${APP_ROOT} && \
     chgrp -R 0 ${APP_ROOT}    && \
     chmod -R g+w ${APP_ROOT}

RUN  ls -laR ${APP_ROOT}

USER 1001

RUN  /usr/libexec/s2i/assemble
