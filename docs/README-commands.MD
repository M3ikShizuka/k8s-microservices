## Kubernetes
### Useful commands
Get `service-account` pod's name by label.
```
kubectl get pod -n ${KUBE_MICROSERVICES_NAMESPACE} -l app=service-account -o jsonpath="{.items[0].metadata.name}"
```

Get `service-account` pod's logs by label.
```
kubectl logs $(eval kubectl get pod -n ${KUBE_MICROSERVICES_NAMESPACE} -l app=service-account -o jsonpath="{.items[0].metadata.name}")
```