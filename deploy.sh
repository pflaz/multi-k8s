docker build -t pawars/multi-client:latest -t pawars/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pawars/multi-server:latest -t pawars/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pawars/multi-worker:latest -t pawars/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push pawars/multi-client:latest
docker push pawars/multi-client:$SHA
docker push pawars/multi-server:latest
docker push pawars/multi-server:$SHA
docker push pawars/multi-worker:latest
docker push pawars/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pawars/multi-server:$SHA
kubectl set image deployments/client-deployment client=pawars/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pawars/multi-worker:$SHA
