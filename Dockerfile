FROM golang:latest AS base

WORKDIR /go-web-app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

FROM gcr.io/distroless/base

COPY --from=base /go-web-app/main .

COPY --from=base /go-web-app/static ./static

EXPOSE 8080

CMD ["./main"]