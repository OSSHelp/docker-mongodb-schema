FROM mongo:4.4-bionic

LABEL maintainer="OSSHelp Team, https://oss.help"
LABEL description="One shot container which creates dbs and users"

COPY entrypoint.sh /usr/local/bin/
USER nobody

ENV MONGODB_HOST=mongodb \
    MONGODB_PORT=27017 \
    MONGODB_USER=root \
    MONGODB_PASSWORD=password \
    MONGODB_TIMEOUT=60

ENTRYPOINT ["entrypoint.sh"]
