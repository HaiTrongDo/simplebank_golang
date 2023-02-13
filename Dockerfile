FROM golang:1.20-alpine AS builder
WORKDIR /app
COPY . .
RUN ls -la
RUN go build -o main main.go
RUN apk add curl
RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz 

# Run stage
FROM alpine:latest
# WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/migrate ./migrate
COPY app.env /app/
COPY start.sh /app/
COPY wait-for.sh /app/
COPY db/migration /app/db/migration
RUN ls -la

EXPOSE 8080
CMD [ "/app/main" ]
ENTRYPOINT [ "/app/start.sh" ]
