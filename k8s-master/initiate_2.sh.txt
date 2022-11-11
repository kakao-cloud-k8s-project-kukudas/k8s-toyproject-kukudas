# VM 생성 및 k8s-master 프로비전 
vagrant destroy -f # 기존에 생성된 VM이 있다면 제거 
vagrant up # VM 생성 및 k8s-master 프로비전

# node 프로비전 
sed -i '/#1/s/^/#/' Vagrantfile # k8s-master에 주석 처리
sed -i '/#2/s/^#//' Vagrantfile # node에 주석 해제
vagrant provision # node 프로비전 

# 클러스터 생성 확인
vagrant ssh k8s-master -- -t 'kubectl get nodes && kubectl get pods -n kube-system' # 쿠버네티스 클러스터 생성 확인, kube-system pods 동작 확인 

# Vagrantfile 주석 되돌리기 
sed -i '/#1/s/^#//' Vagrantfile # k8s-master에 주석 처리 
sed -i '/#2/s/^/#/' Vagrantfile # node에 주석 처리

# k8s-master 접속 
vagrant ssh k8s-master