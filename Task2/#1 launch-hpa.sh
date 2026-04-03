#!/bin/bash
helm uninstall my-prometheus-adapter
helm uninstall prometheus-operator

minikube delete --all --purge
minikube start

kubectl apply -f ../task2/deployment.yaml
kubectl get deployment 
kubectl apply -f ../task2/service.yaml
kubectl get service 
kubectl apply -f ../task2/hpa.yaml
kubectl get hpa 

minikube addons enable metrics-server 
kubectl get deployment metrics-server

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install prometheus-operator prometheus-community/kube-prometheus-stack
helm install my-prometheus-adapter prometheus-community/prometheus-adapter -f values.yaml

kubectl apply -f servicemonitor.yaml


