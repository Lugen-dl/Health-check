FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache \ 
    bash \ 
    curl

RUN mkdir -p /app/logs && chmod 777 /app/logs
COPY /main/server_stat_check_v0.1.sh /app/
RUN chmod +x /app/server_stat_check_v0.1.sh

ENTRYPOINT [ "bash" ]
CMD [ "/app/server_stat_check_v0.1.sh" ]