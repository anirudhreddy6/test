FROM golang:1.18 as builder

#set the workdir
workdir /app

#Retrieve the dependencies
COPY go.* ./
RUN go mod tidy

#Copy the source code
COPY . ./

#Build the application
#-o hello specifies the output file name hello
#disabling cgo and target os is linux
RUN CGO_ENABLED=0 GOOS=linux go build -o hello

#use the official debian for lean image
FROM debian:buster-slim

#setting the workdir
workdir /root

#copyy the binary from the builder stage
COPY --from=builder /app/hello .

#Run the Binary
CMD ["./hello"]
