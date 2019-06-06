# Test-bed including OST

## Getting started

Please note that the current version requires a manual restart of the backend server, since when the backend service starts, the DB isn't ready yet.

```bash
docker-compose up -d
docker ps | grep ost_backend
# This will return the container id of ost_backend service
# You typically only need the first 3 or 4 characters of the ID.
docker ps [CONTAINER ID]
```

## Using the OST

Open a browser and visit the [OST home page](http://127.0.0.1:84). Do not use `localhost`, as this will not work - the GUI then tries to connect to an internal service running at ITTI, which is not accessible.

To login, use the following credentials: `admin19/adminpass`
