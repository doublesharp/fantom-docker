FROM alpine:3.13 as build-stage

ARG FANTOM_NETWORK=opera
ARG GITHUB_BRANCH=release/1.0.2-rc.5
ARG GITHUB_URL=https://github.com/Fantom-foundation/go-${FANTOM_NETWORK}.git
ARG GITHUB_DIR=go-${FANTOM_NETWORK}

ARG GOROOT=/usr/lib/go 
ARG GOPATH=/go 
ARG PATH=$GOROOT/bin:$GOPATH/bin:/build:$PATH

RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  # get the build dependencies for go
  make gcc go musl-dev linux-headers git; \
  # install fantom client from github
  mkdir -p ${GOPATH}; cd ${GOPATH}; \
  git clone --single-branch --branch ${GITHUB_BRANCH} ${GITHUB_URL}; cd ${GITHUB_DIR}; \
  # build and copy the binary
  make -j$(nproc); mv build/${FANTOM_NETWORK} /usr/local/bin; \
  # remove our build dependencies
  rm -rf /go; apk del .build-deps; 

FROM alpine:latest as opera

RUN apk add --no-cache ca-certificates

ENV FANTOM_NETWORK=opera
ENV FANTOM_GENESIS="mainnet.g"
ENV FANTOM_API=eth,ftm,net,web3
ENV FANTOM_VERBOSITY=2
ENV FANTOM_CACHE=4096

# copy the binary 
COPY --from=build-stage /usr/local/bin/${FANTOM_NETWORK} /usr/local/bin/${FANTOM_NETWORK}

COPY run.sh /usr/local/bin
COPY entrypoint.sh /usr/local/bin

WORKDIR "/root/.${FANTOM_NETWORK}"

EXPOSE 5050 18545 18546 18547 19090

VOLUME [ "/root/.${FANTOM_NETWORK}" , "/genesis"]

ENTRYPOINT [ "entrypoint.sh" ]

CMD ["run.sh"]
