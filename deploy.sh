docker build -t xm0404/multi-client:latest -t xm0404/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t xm0404/multi-server:latest -t xm0404/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t xm0404/multi-worker:latest -t xm0404/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push xm0404/multi-client:latest
docker push xm0404/multi-server:latest
docker push xm0404/multi-worker:latest

docker push xm0404/multi-client:$GIT_SHA
docker push xm0404/multi-server:$GIT_SHA
docker push xm0404/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=xm0404/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=xm0404/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=xm0404/multi-worker:$GIT_SHA