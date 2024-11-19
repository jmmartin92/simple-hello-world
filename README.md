# simple-hello-world

Repo contains a simple hello world application that is written in node.js. 

The directory structure is:
.
├── CHANGELOG.md
├── Dockerfile
├── Jenkinsfile
├── Makefile
├── README.md
├── directory-structure.md
├── htmlfiles
│   └── helloworld.html
├── k8syaml
│   ├── deploymentService.yaml
│   ├── ingress.yaml
│   └── serviceAccount.yaml
├── package.json
└── server.js


The server starts on port 8000.

## Assumptions
This guide assumes that you have docker installed locally.
Note: other containerisation applications are available, e.g. rancher-desktop

### Docker build
To build the application:
```bash
docker build -f ./Dockerfile -t hello-world-app:1.0.0 . --no-cache
```
Note: this should be parameterised from GitHub for semantic versioning


### Docker Run
To run using docker
```bash
docker run -p 8000:8000 hello-world-app:1.0.0
```

### Perform manifest validation
kubeval can be used to validate the yaml files
```bash
kubeval ./k8syaml/deploymentService.yaml
kubeval ./k8syaml/serviceAccount.yaml
kubeval ./k8syaml/ingress.yaml
```

### Perform static analysis of yaml
kube-score gives a list of recommendations of how it can be im proved
```bash
kube-score score ./k8syaml/deploymentService.yaml
kube-score score ./k8syaml/serviceAccount.yaml
kube-score score ./k8syaml/ingress.yaml
```

### Deploy:
```bash
kubectl apply -f ./k8syaml/serviceAccount
kubectl apply -f ./k8syaml/deploymentService.yaml
```

###Access:
```bash
curl -vv http://localhost:30000
```

Note: if you change the service, removing the lines below
```yaml
    nodePort: 30000
  type: NodePort
```
then you can use port-forward to connect e.g.
```bash
kubectl port-forward -n ns-simple-hw services/simple-hw-service 8000:8000
```