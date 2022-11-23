# Service   : Django에서 갱신 버튼을 누르면 k8s-master node로부터 페이지를 삭제시켜주는 쉘 파일을 실행시키는  쉘 파일
# Last Edit : 2022.10.06 보근

#########  Django -> Server INPUT  ###########
page_name=$1
##############################################

######### DELETE Databases ###############
# Database delete
echo "DELETE FROM home_instance WHERE page_name='${page_name}';" \ | mysql -uuser3 -h 192.168.1.152 vagrant;


# Django -> Server -> k8s-master node
# vagrant 실행을 위해 아래 주소로 이동 후 vagrant ssh로 접근
# /home/vagrant/ingress/test/deleteservice.sh 쉘 파일 실행

$(cd /root/vagrant-ansible-kubernetes-1.21; vagrant ssh k8s-master -- -t '/home/vagrant/ingress/test/deleteservice.sh' $page_name;)
exit