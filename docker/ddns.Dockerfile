FROM alpine
COPY ./updateDNS.sh ./
ENTRYPOINT [ "sh", "./updateDNS.sh" ]