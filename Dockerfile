# Use the offical Golang image to build the app: https://hub.docker.com/_/golang
FROM golang:1.18.2 as builder

# Copy code to the image
WORKDIR /go/src/github.com/superfly/go-example
COPY . .

# Build the app
RUN CGO_ENABLED=0 GOOS=linux go build -v -o app

# Start a new image for production without build dependencies
FROM alpine
RUN apk add --no-cache ca-certificates

# Copy the app binary from the builder to the production image
COPY --from=builder /go/src/github.com/superfly/go-example/app /app

# Run the app when the vm starts
CMD ["/app"]
