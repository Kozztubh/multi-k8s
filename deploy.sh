docker build -t kaustubhrd/multi-client:latest -t kaustubhrd/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t kaustubhrd/multi-server:latest -t kaustubhrd/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t kaustubhrd/multi-worker:latest -t kaustubhrd/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

docker push kaustubhrd/multi-client:latest
docker push kaustubhrd/multi-server:latest
docker push kaustubhrd/multi-worker:latest

docker push kaustubhrd/multi-client:$SHA
docker push kaustubhrd/multi-server:$SHA
docker push kaustubhrd/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kaustubhrd/multi-server:$SHA
kubectl set image deployments/client-deployment client=kaustubhrd/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kaustubhrd/multi-worker:$SHA
  