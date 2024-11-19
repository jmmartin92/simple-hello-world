help:
	@echo "build: builds the docker image fore the hello-world-app"
	@echo "run: runs the docker image for the hello-world-app"
	@echo "kubeval: performs manifest validation k8syaml"
	@echo "kube-score: static code analysis manifest"
	@echo "deploy: deploys manifests"

build:
	docker build -f ./Dockerfile -t hello-world-app:1.0.0 . --no-cache

run:
	docker run -p 8000:8000 hello-world-app:1.0.0

kubeval:
	kubeval ./k8syaml/deploymentService.yaml
	kubeval ./k8syaml/serviceAccount.yaml

kube-score:
	kube-score score ./k8syaml/deploymentService.yaml
	kube-score score ./k8syaml/serviceAccount.yaml

deploy:
	kubectl apply -f ./k8syaml/deploymentService.yaml
	kubectl apply -f ./k8syaml/serviceAccount.yaml
