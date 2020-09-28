#!/bin/bash
docker build -t koagyu/complex-client:latest -t koagyu/complex-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t koagyu/complex-server:latest -t koagyu/complex-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t koagyu/complex-worker:latest -t koagyu/complex-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push koagyu/complex-client:latest
docker push koagyu/complex-server:latest
docker push koagyu/complex-worker:latest

docker push koagyu/complex-client:$GIT_SHA
docker push koagyu/complex-server:$GIT_SHA
docker push koagyu/complex-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=koagyu/complex-client:$GIT_SHA
kubectl set image deployments/server-deployment server=koagyu/complex-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=koagyu/complex-worker:$GIT_SHA
