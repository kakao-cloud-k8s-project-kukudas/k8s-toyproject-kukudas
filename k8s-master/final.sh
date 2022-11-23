#ingress ip주소 받아오기
ipnum=$(vagrant ssh k8s-master -- -t ". ~/ingress/test/ip.sh")
#프로젝트 네임을 받으면 DNS서버에 넣음
echo $ipnum ${projectname}.com >> a.txt
perl -pi -e 's/\015//g' a.txt
cat a.txt >> /etc/hosts