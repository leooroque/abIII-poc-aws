#!/bin/bash

if [ -d /efs/crt/ ]; then 
[[ `diff /efs/crt/ca.pem /efs/crt/stage/ca.pem` ]] &&  
   (cp -f /efs/crt/stage/ca.pem /efs/crt/ && nginx -s reload) ||
   (echo "arquivo sem alteracao")
else 
	echo "diretorio nao existe"
fi
