FROM golang:1.16-alpine3.13 as build-stage

ENV FANTOM_NETWORK=opera
ENV GITHUB_BRANCH=release/1.0.0-rc.1
ENV GITHUB_URL=https://github.com/Fantom-foundation/go-${FANTOM_NETWORK}.git
ENV GITHUB_DIR=go-${FANTOM_NETWORK}

RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  # get the build dependencies for go
  make gcc musl-dev linux-headers git; \
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
ENV FANTOM_API=eth,ftm,debug,admin,web3,personal,net,txpool
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