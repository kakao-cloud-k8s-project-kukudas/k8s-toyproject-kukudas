#!/bin/bash

number=$1
pagename=$2


n=`expr $number + 30000`
echo "
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${pagename}
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ${pagename}
  template: # 컨테이너 내용 
    metadata:
      name: ${pagename}
      labels:
        app: ${pagename}
    spec:
      containers:
      - name: ${pagename}
        image: httpd
        ports:
        - containerPort: 80
        volumeMounts:
        - name: ${pagename}vol
          mountPath: /usr/local/apache2/htdocs
      volumes:
      - name: ${pagename}vol
        configMap:
          name: ${pagename}cm 
        
---     

apiVersion: v1
kind: Service
metadata:
  name: ${pagename}
spec:
  ports:
  - name: ${pagename}-port
    port: 80 # service의 포트
    targetPort: 80 # pod의 포트 
    nodePort: $n
  selector:
    app: ${pagename}
  type: NodePort " > /home/vagrant/ingress/test/http-${pagename}.yml

kubectl apply -f /home/vagrant/ingress/test/http-${pagename}.yml
