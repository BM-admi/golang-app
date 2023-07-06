# syntax=docker/dockerfile:1
FROM golang:1.19 AS build-stage
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /server

##
FROM build-stage AS run-test-stage
RUN go test -v ./...

##
FROM gcr.io/distroless/base-debian11 AS build-release-stage
WORKDIR /
COPY --from=build-stage /server /server
EXPOSE 8080
USER nonroot:nonroot
ENTRYPOINT ["/server"]
#CMD ["/server"]
