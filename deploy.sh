docker build -t filmboy3/multi-client:latest -t filmboy3/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t filmboy3/multi-server:latest -t filmboy3/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t filmboy3/multi-worker:latest -t filmboy3/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push filmboy3/multi-client:latest
docker push filmboy3/multi-server:latest
docker push filmboy3/multi-worker:latest

docker push filmboy3/multi-client:$SHA
docker push filmboy3/multi-server:$SHA
docker push filmboy3/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=filmboy3/multi-server:$SHA
kubectl set image deployments/client-deployment client=filmboy3/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=filmboy3/multi-worker:$SHA