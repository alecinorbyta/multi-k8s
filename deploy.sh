docker build -t alecin/multi-client:latest -t alecin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t alecin/multi-server:latest -t alecin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t alecin/multi-worker:latest -t alecin/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push alecin/multi-client:latest
docker push alecin/multi-server:latest
docker push alecin/multi-worker:latest
docker push alecin/multi-client:$SHA
docker push alecin/multi-server:$SHA
docker push alecin/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alecin/multi-server:$SHA
kubectl set image deployments/client-deployment client=alecin/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=alecin/multi-worker:$SHA