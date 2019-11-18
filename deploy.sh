docker build -t ajm2/multi-client:latest -t ajm2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ajm2/multi-server:latest -t ajm2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ajm2/multi-worker:latest -t ajm2/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push ajm2/multi-client:latest
docker push ajm2/multi-server:latest
docker push ajm2/multi-worker:latest
docker push ajm2/multi-client:$SHA
docker push ajm2/multi-server:$SHA
docker push ajm2/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ajm2/multi-server:$SHA
kubectl set image deployments/worker-deployment server=ajm2/multi-worker:$SHA
kubectl set image deployments/client-deployment server=ajm2/multi-client:$SHA

