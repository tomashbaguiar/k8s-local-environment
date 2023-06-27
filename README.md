# Kubernetes Local Environment

Contents of the folder:
- k8s deployment/service/volume files
- bash scripts for creating and deleting the environment

## Running the pods and services

To run the pods and services execute:
```bash
$ kubectl apply -f app1-(deploy|service).yaml \
    -f app2-(deploy|service).yaml \
    .. \
    -f appn-(deploy|service).yaml
```
or
```bash
$ bash environment-up.sh
```

## Stoping the pods and services

To remove the pods and services:
```bash
$ kubectl delete -f app1-(deploy|service).yaml \
    -f app2-(deploy|service).yaml \
    .. \
    -f appn-(deploy|service).yaml
```
or
```bash
$ bash environment-down.sh
```

## Running scripts with `dry run` option

To check what the scripts would do if ran, use `--dry-run=client` option
```bash
$ bash environment-downsh --dry-run=client
```

