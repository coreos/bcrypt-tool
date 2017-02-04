FROM golang:1.7
MAINTAINER colin.hom@coreos.com
RUN curl https://glide.sh/get | sh
ENV GOPATH /gopath
ADD . /gopath/src/github.com/coreos/bcrypt-tool
WORKDIR /gopath/src/github.com/coreos/bcrypt-tool
RUN glide install

RUN go build  -o /bin/bcrypt-tool ./
ENTRYPOINT /bin/bcrypt-tool
