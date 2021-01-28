# mongodb-schema

[![Build Status](https://drone.osshelp.ru/api/badges/docker/mongodb-schema/status.svg)](https://drone.osshelp.ru/docker/mongodb-schema)

## Description

One-shot container for create MongoDB databases and users.

## Deploy examples

### Docker Compose

``` yaml
  mongodb-schema:
    image: osshelp/mongodb-schema:stable
    restart: "no"
    environment:
      MONGODB_HOST: mongodb
      MONGODB_USER: root
      MONGODB_PASSWORD: $MONGODB_PASSWORD
      MONGODB_DBS: "DB1_NAME:$USER1_PASSWORD, DB2_NAME:$USER2_PASSWORD"
    networks:
      - net
```

### Docker swarm

``` yaml
  mongodb-schema:
    image: osshelp/mongodb-schema:stable
    deploy:
      restart_policy:
        condition: none
    environment:
      MONGODB_HOST: mongodb
      MONGODB_USER: root
      MONGODB_PASSWORD: $MONGODB_PASSWORD
      MONGODB_DBS: "DB1_NAME:$USER1_PASSWORD, DB2_NAME:$USER2_PASSWORD"
    networks:
      - net
```

## Parameters

Setting|Default|Description
---|---|---
`MONGODB_HOST`|`mongodb`|MongoDB host
`MONGODB_PORT`|`27017`|MongoDB port
`MONGODB_USER`|`root`|MongoDB superuser
`MONGODB_PASSWORD`|`password`|MongoDB superuser password
`MONGODB_TIMEOUT`|`60`|Timeout in seconds for wating MongoDB host connection
`MONGODB_DBS`|-|List of DB_NAME:PASSWORD (delimiter: space or comma. USERNAME is equal to DBNAME)

### Internal usage

For internal purposes and OSSHelp customers we have an alternative image url:

``` yaml
  image: oss.help/pub/mongodb-schema:stable
```

There is no difference between the DockerHub image and the oss.help/pub image.

## Links

- [MongoDB Documentation](https://docs.mongodb.com/manual/)

## TODO

- Add fixture dumps support (restore from dump if DB doesn't exits)
