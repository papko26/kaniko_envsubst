FROM gcr.io/kaniko-project/executor:debug
SHELL ["/busybox/sh", "-c"]
RUN  wget https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-Linux-x86_64 -O /kaniko/envsubst && chmod a+x /kaniko/envsubst
