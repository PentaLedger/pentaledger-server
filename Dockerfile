# Build Stage
FROM golang:1.21 AS builder
WORKDIR /app

# Copy and download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Copy the source code and build the binary
COPY . .
RUN go build -o app .

# Run Stage
FROM debian:bookworm-slim
WORKDIR /app

# Copy the binary from the builder stage
COPY --from=builder /app/app /app/app

# Set the entrypoint
ENTRYPOINT ["/app/app"]
