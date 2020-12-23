FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get -y install curl goaccess zip apache2

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

COPY stats.sh /
RUN chmod +x stats.sh
#ENTRYPOINT ["/stats.sh"]

# expose apache2 port
EXPOSE 80

# run httpd in the foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND

