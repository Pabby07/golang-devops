FROM golang:1.16.5 as development
WORKDIR go-gin-project
COPY go.mod go.sum /usr/src/app/
COPY . .
RUN go mod download
EXPOSE 5500
CMD ["go", "run", "app.go"]