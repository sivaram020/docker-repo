FROM ubuntu:18.04

# install dependencies
RUN apt-get update -y && apt-get install apache2 -y

# install app
RUN rm -rf /var/www/html
ADD src/ /var/www/html/

# configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
    echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
    echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \
    echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \
    chmod 755 /root/run_apache.sh

    EXPOSE 80

    CMD /root/run_apache.sh
