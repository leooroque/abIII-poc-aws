#FROM centos:7
FROM amazonlinux:latest
LABEL maintainer="roquleon"
RUN amazon-linux-extras install nginx1
#RUN yum install -y epel-release
RUN yum install -y nginx
RUN yum install -y vim
RUN yum install -y cronie
RUN yum install -y amazon-efs-utils
RUN yum install -y unzip
RUN yum install -y less
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sh ./aws/install 
CMD /
RUN mkdir -p efs/crt/stage
RUN mkdir crt
RUN mkdir script
COPY ./crt/ca.pem /efs/crt/
COPY ./crt/ca.pem /efs/crt/stage/
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
