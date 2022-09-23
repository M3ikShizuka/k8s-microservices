# Microservices
* OAuth2 [Ory-Hydra](https://github.com/ory/hydra) self-hosted service
* [Service-account](https://github.com/M3ikShizuka/service-account) user's account management service.

## Note
The main way to build and run a project is by using `Makefiles`.  
Examine the contents of the `Makefile` file, in the `root` directory of the project, to understand what is going on and how.   

Some files are pre-processed by `envsubst` to use `.env`.

## Concept
[OAuth Ory-Hydra use concept](docs/hydra/README-concept.MD)

## More tech details:
* [Ory-Hydra readme](docs/hydra/README.MD)
* [Service-account readme](https://github.com/M3ikShizuka/service-account/README.MD)

## Pre-Install
* [docker](https://www.docker.com/)
* [kind](https://kind.sigs.k8s.io/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [helm](https://helm.sh/)
* [GNU envsubst](https://www.gnu.org/software/gettext/manual/html_node/envsubst-Invocation.html)

## Configurations
<b>(<span style="color:red">Change the parameters here when used in production</span>)</b>
* Duplicate `.env.example` and rename to `.env`. Change the paths to the hydra src directory and the service-account src directory.
* [Change configs for service account](https://github.com/M3ikShizuka/service-account/README.MD##Configurations)
* [Change configs for hydra](docs/hydra/README.MD##Configurations)

## Fast run by Kubernetes (kind)
1. Duplicate `.env.example` and rename to `.env`. Change the paths to the hydra src directory and the service-account src directory.
2. Build docker images.
```bash
make k8s-kind-build
```
3. Fast create cluster, load the built local images to kind, and run.
```bash
make k8s-kind-fast
```
4. Open in browser: http://account.localhost/