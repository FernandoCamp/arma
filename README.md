Build with
```shell
docker build --platform linux/amd64 -t arma .
```

Start the server with
```shell
docker-compose run arma './ArmaReforgerServer' '-config' './configs/config.json'
```