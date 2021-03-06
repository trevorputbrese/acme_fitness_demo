#!/bin/bash
echo "Please enter a secret for the 'cart service' to use when authenticating to the redis server:"
read cart_svc_secret
kubectl create secret generic cart-redis-pass --from-literal=password=$cart_svc_secret
kubectl apply -f cart-redis-total.yaml
kubectl apply -f cart-total.yaml
echo "Please enter a secret for the 'catalog service' to use when authenticating to the cache server:"
read catalog_svc_secret
kubectl create secret generic catalog-mongo-pass --from-literal=password=$catalog_svc_secret
kubectl create -f catalog-db-initdb-configmap.yaml
kubectl apply -f catalog-db-total.yaml
kubectl apply -f catalog-total.yaml
kubectl apply -f payment-total.yaml
wait
echo "Please enter a secret for the 'order service' to use when authenticating to the cache server:"
read order_svc_secret
kubectl create secret generic order-postgres-pass --from-literal=password=$order_svc_secret
kubectl apply -f order-db-total.yaml
kubectl apply -f order-total.yaml
echo "Please enter a secret for the mongo DB password:"
read mongo_db_secret
echo "Please enter a secret for the redis password:"
read redis_secret
kubectl create secret generic users-mongo-pass --from-literal=password=$mongo_db_secret
kubectl create secret generic users-redis-pass --from-literal=password=$redis_secret
kubectl create -f users-db-initdb-configmap.yaml
kubectl apply -f users-db-total.yaml
kubectl apply -f users-redis-total.yaml
kubectl apply -f users-total.yaml
wait
kubectl apply -f frontend-total.yaml
kubectl get services -l service=frontend


