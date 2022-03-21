FROM golang:1.16

WORKDIR /go/src
ENV PATH="/go/bin:${PATH}"

RUN go get -u github.com/spf13/cobra@latest && \
    go get -u github.com/xuri/excelize/v2 && \
    go get -u github.com/BurntSushi/toml && \
    go install github.com/golang/mock/mockgen@v1.5.0


RUN usermod -u 1000 www-data

#USER www-data

USER root

CMD ["tail", "-f", "/dev/null"]