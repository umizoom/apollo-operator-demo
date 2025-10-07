# Ship, Scale and Simplify your GraphOps with Kubernetes-native Resources

This is a workshop that will be running as part of GraphQL Summit 2025. 

Press the "**Use this template**" button to make a copy of this template into your personal
GitHub account!

Below are some of the commands we're using in the workshop to allow for ease of copying!

## Useful Commands

### Creating a Cluster

```shell
kind create cluster --name operator-workshop-cluster
```
### Run the Bootstrap Script

```shell
./bootstrap.sh
```
_Make sure to run this in the folder the checked out repo is cloned into!_

### Creating API Keys

```shell
rover api-key create summit-2025-operator-workshop operator operator-workshop-key
```
```shell
kubectl -n apollo-operator create secret generic --from-literal=APOLLO_KEY=<<YOUR_KEY>> apollo-api-key
```

### Check Pods Are Running

```shell
kubectl get pods -A
```

### Retrieve ArgoCD Admin Password

```shell
kubectl -n argocd get secrets/argocd-initial-admin-secret --template='{{.data.password}}' | base64 -d
```

### Access ArgoCD

```shell
kubectl -n argocd port-forward service/argocd-server 8080:80
```

### Access Sandbox

```shell
kubectl -n apollo-operator port-forward service/retail 4000:80
```

### Get Operator Logs

```shell
kubectl -n apollo-operator logs deployment/apollo-operator
```

