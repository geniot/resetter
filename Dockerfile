# =========================================
# Stage 1: Build the Go Application
# =========================================
FROM golang:latest AS resetter
WORKDIR /resetter
COPY go.mod .
COPY go.sum .
RUN go mod download
COPY . .
# Build the Go application
RUN go build -buildvcs=false -o /resetter github.com/geniot/resetter/src
# =========================================
# Stage 2: Prepare executable
# =========================================
FROM golang:latest as run
WORKDIR /app
COPY --from=resetter /resetter ./resetter
EXPOSE 8333
CMD ["/app/resetter"]