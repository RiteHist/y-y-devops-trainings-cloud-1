FROM golang:1.21.3 as build
WORKDIR /
COPY /catgpt/. .

RUN go mod download
RUN CGO_ENABLED=0 go build -o /bin/app

FROM gcr.io/distroless/static-debian12:latest-amd64
COPY --from=build /bin/app /
CMD ["/app"]