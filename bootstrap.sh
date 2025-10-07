#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "PLEASE ENSURE THAT YOUR KUBE CONTEXT IS POINTING AT YOUR WORKSHOP CLUSTER!"
echo "Your current context is $(kubectl config current-context)"
echo "If that is not the correct context please exit, change context, and re-run this script"
read -rp "Press enter to continue"
echo ""

echo "Creating ArgoCD Namespace"
kubectl create namespace argocd || echo "Skipping as namespace already exists"
read -rp "Press enter to continue"
echo ""

echo "Installing ArgoCD"
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl rollout status -n argocd statefulset argocd-application-controller
read -rp "Press enter to continue"
echo ""

echo "Applying bootstrap resources"
kubectl apply -f "$SCRIPT_DIR/bootstrap.yaml"
read -rp "Press enter to continue"
echo ""

echo "Patching ArgoCD Resources"
kubectl patch -n argocd cm argocd-cm -p '{ "data": { "timeout.reconciliation": "5s", "timeout.reconciliation.jitter": "1s" }}'
kubectl rollout restart -n argocd statefulset argocd-application-controller
kubectl rollout status -n argocd statefulset argocd-application-controller
read -rp "Press enter to continue"
echo ""

echo "Getting ArgoCD Password"
echo "Password is '$(kubectl -n argocd get secrets/argocd-initial-admin-secret --template='{{.data.password}}' | base64 -d)'"
echo ""

echo "Bootstrapping Completed!"

