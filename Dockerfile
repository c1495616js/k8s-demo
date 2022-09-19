FROM golang:1.19-rc-alpine as builder

WORKDIR /

COPY . .

RUN go mod tidy

RUN go build -o main

# 多階段建構
FROM alpine:3.15.0-rc.4

WORKDIR /

COPY --from=builder /main .

EXPOSE 8080

ENTRYPOINT ["./main"]