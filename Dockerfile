FROM golang:1.12
ARG GOARCH=amd64
ARG KANIKO_COMMIT=7a17e42af9b65facfeb219c4bd52b791e7f2f70c
WORKDIR /kaniko-build
RUN git clone https://github.com/GoogleContainerTools/kaniko . && git checkout ${KANIKO_COMMIT}
RUN make GOARCH=${GOARCH} && make out/warmer
RUN wget https://github.com/a8m/envsubst/releases/download/v1.1.0/envsubst-Linux-x86_64 -O out/envsubst && chmod a+x out/envsubst

FROM busybox
COPY --from=0 /kaniko-build/out/* /kaniko/
COPY --from=0 /kaniko-build/files/ca-certificates.crt /kaniko/ssl/certs/
ENV HOME /root
ENV USER /root
ENV PATH="/kaniko:${PATH}"
ENV SSL_CERT_DIR=/kaniko/ssl/certs
ENV DOCKER_CONFIG /kaniko/.docker/
ENTRYPOINT ["/kaniko/executor"]
