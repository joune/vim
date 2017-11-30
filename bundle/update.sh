for i in `ls`; do echo $i; cd $i && (git pull || true) && cd ..; done
