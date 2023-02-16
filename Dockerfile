#FROM centos:7
FROM amazonlinux:latest
LABEL maintainer="roquleon"
RUN amazon-linux-extras install nginx1
#RUN yum install -y epel-release
RUN yum install -y nginx
RUN yum install -y vim
RUN yum install -y cronie
RUN yum install -y amazon-efs-utils
RUN yum -y install wget
RUN wget https://bootstrap.pypa.io/pip/3.4/get-pip.py -O /tmp/get-pip.py
RUN wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py
RUN pip3 install botocore 
CMD /
RUN mkdir -p efs/crt
RUN mkdir crt
RUN mkdir script
COPY ./crt/ca.pem /efs/crt/
COPY ./watchCA.sh /script/
COPY ./default.conf /etc/nginx/conf.d/
COPY ./crt/* /crt/
COPY ./cronjob.sh /etc/cron.d/cronjob.sh
RUN chmod 0644 /etc/cron.d/cronjob.sh
RUN crontab /etc/cron.d/cronjob.sh
RUN touch /var/log/cron.log
RUN /usr/sbin/crond
EXPOSE 443
CMD crond && exec nginx -g 'daemon off;'
