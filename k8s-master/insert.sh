# Service   : Django에서 갱신 버튼을 누르면 k8s-master node로부터 페이지 배포 시켜주는 쉘 파일을 실행시키는  쉘 파일
# Last Edit : 2022.10.06 보근

#########  Django -> Server INPUT  ###########
page_name=$1
service=$2
git_url=$3
index_folder=$4
##############################################

######### Insert Databases ###############
# 서버에서 가져온 정보 -> DB 저장
echo "INSERT INTO home_instance VALUES (NULL, '$page_name', '$service', '$git_url', NULL, '$index_folder');" \ | mysql -uuser3 -h 192.168.1.152 vagrant;

# 삽입한 데이터의 ID 값을 number 인자로 가져옴
# NodePort 배포시 30000+number 을 하기 위함
number=$(echo "SELECT id FROM home_instance WHERE page_name='$page_name' LIMIT 1;" | mysql -N -uuser3 -h 192.168.1.152 vagrant;)

# Django -> Server -> k8s-master node
# vagrant 실행을 위해 아래 주소로 이동 후 vagrant ssh로 접근
# /home/vagrant/ingress/test/startservice.sh 쉘 파일 실행   

$(cd /root/vagrant-ansible-kubernetes-1.21; vagrant ssh k8s-master -- -t '/home/vagrant/ingress/test/startservice.sh' $number $page_name $service;)