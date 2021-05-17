docker build -t silviocifone/fibonaccicalculator-client:latest -t silviocifone/fibonaccicalculator-client:$SHA -f ./client/Dockerfile ./client
docker build -t silviocifone/fibonaccicalculator-server:latest -t silviocifone/fibonaccicalculator-server:$SHA -f ./server/Dockerfile ./server
docker build -t silviocifone/fibonaccicalculator-worker:latest -t silviocifone/fibonaccicalculator-worker:$SHA -f ./worker/Dockerfile ./worker

docker push silviocifone/fibonaccicalculator-client:latest
docker push silviocifone/fibonaccicalculator-server:latest
docker push silviocifone/fibonaccicalculator-worker:latest

docker push silviocifone/fibonaccicalculator-client:$SHA
docker push silviocifone/fibonaccicalculator-server:$SHA
docker push silviocifone/fibonaccicalculator-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=silviocifone/fibonaccicalculator-server:$SHA
kubectl set image deployments/client-deployment client=silviocifone/fibonaccicalculator-client:$SHA
kubectl set image deployments/worker-deployment worker=silviocifone/fibonaccicalculator-worker:$SHA
