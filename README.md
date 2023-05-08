# jack-all
Playground repositorty for messing about

## Pre-requisites
* Python 3.11.3

## FastAPI Python Services
Wanted to give FastAPI a try as have previously used Flask

### Run Locally
Install dependencies
```
make init
```

Run Application
```
make run
```

Lint Project
```
make lint
```

Run Tests
```
make test
```

### Build and Run in Docker

```
make docker-build docker-run
```

Will start the service at localhost:80.

To tear down and remove container

```
make docker-stop
```
