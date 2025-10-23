FROM alpine:3.22.2

WORKDIR /app

RUN apk add --no-cache bash coreutils curl

COPY yabs.sh .

RUN chmod +x *.sh

CMD ["/app/yabs.sh"]

