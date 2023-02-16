#!/bin/bash
/usr/local/bin/aws s3api get-object --bucket "openbankingtruststore" --key "ca.pem" "/efs/crt/stage/ca.pem"
if [ -d /efs/crt/stage/ ]; then 
[[ `diff /efs/crt/ca.pem /efs/crt/stage/ca.pem` ]] &&  
   (cp -f /efs/crt/stage/ca.pem /efs/crt/ && /usr/sbin/nginx -s reload) ||
   (echo "arquivo sem alteracao")
else 
	echo "diretorio nao existe"
fi
