FROM quay.io/openshifthomeroom/workshop-dashboard:5.0.0

ENV GIT_REPO=https://github.com/xtophd/RHEL8-Workshop
ENV GIT_REF=summit-2021-dev

ENV APP_ROOT=/tmp/src

ENV GIT_TMP=/tmp/git-clone

ENV DOC_SRC=${GIT_TMP}/documentation/_include
ENV DOC_DST=${APP_ROOT}/workshop/content/documentation

USER root

COPY . ${APP_ROOT}

RUN  git clone --depth 1 -b ${GIT_REF} ${GIT_REPO} ${GIT_TMP}

RUN  cp -R ${DOC_SRC}/* ${DOC_DST}

RUN  rm -rf ${GIT_TMP}         && \
     rm -rf ${APP_ROOT}/.git*  && \
     chown -R 1001 ${APP_ROOT} && \
     chgrp -R 0 ${APP_ROOT}    && \
     chmod -R g+w ${APP_ROOT}

RUN  ls -laR ${APP_ROOT}

USER 1001

RUN  /usr/libexec/s2i/assemble
