FROM ubuntu:20.04

ADD init-ubuntu20.04.sh /init.sh

RUN sh /init.sh && rm init.sh && service ssh start

CMD passwd