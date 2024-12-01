#Stage 1:
    FROM golang:1.22.5 AS builder

    WORKDIR /app
    
    COPY go.mod ./
    
    RUN go mod download
    
    COPY . .
    
    RUN go build  -o go-web-app .
    
    # Stage 2:
    FROM gcr.io/distroless/base
    
    COPY --from=builder /app/go-web-app .
    
    COPY --from=builder /app/static ./static
    
    EXPOSE 8080
    
    CMD ["./go-web-app"]
    