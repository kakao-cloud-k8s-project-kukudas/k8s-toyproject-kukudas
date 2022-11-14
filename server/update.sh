#!/bin/bash

page_name=$1
index_folder=$2
git_url=$3

# GIT CLONE
rm -rf /home/vagrant/${index_folder}
mkdir /home/vagrant/${index_folder}

git clone $git_url

# cp page
cp /home/vagrant/${index_folder}/index.html /home/vagrant/ingress/test/${page_name}/index.html

# 페이지 바꿔서 적용시키
kubectl delete cm ${page_name}cm
kubectl create cm ${page_name}cm --from-file /home/vagrant/ingress/test/${page_name}/index.html
kubectl rollout restart deployment ${page_name}
