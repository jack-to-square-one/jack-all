# jack-all
Playground repositorty for messing about

## Pre-requisites
* Python 3.11.3+
* Docker
* Minikube
* Kubectl

## FastAPI Python Service
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
make docker-build docker-start
```

Will start the service at localhost:80. It will also wait for the container to become healthy.

Verify you can access the api with

```
make docker-verify-service
```

To tear down and remove container

```
make docker-stop
```

### Deploy to local minikube cluster
Start cluster and set it to look at docker images
```
k8s-cluster-start
```

Build the docker image

```
make docker-build
```

Deploy in K8s
```
k8s-deploy
```

Verify successful deployment
```
k8s-verify-service
```

Delete deployment
```
k8s-delete
```


### CI/CD
Currently implemented with Github actions. Includes testing, building and deploying the service in Docker.

Waiting for the container to become healthy relies on [jordyv/wait-for-healthy-container](https://github.com/jordyv/wait-for-healthy-container), which is pulled in as a project submodule.

The workflow doesn't make use of some avaible github actions, instead I've chosen to use the workflow to call the project Makefile. I prefer to be able to run as much of my cicd pipeline locally as possible, and local execution of github actions requires additional set-up.

Linting is done with Black and the build will fail if there are any linting errors.
