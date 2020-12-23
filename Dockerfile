FROM ubuntu:20.04

# get basic dependencies
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get -y install curl webalizer zip apache2 jq

# install aws cli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install

# get stats script and make executable
COPY stats.sh /
RUN chmod +x stats.sh
ENTRYPOINT ["/stats.sh"]

# expose apache2 port
EXPOSE 80

# run httpd in the foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND

