FROM ubuntu:16.04

RUN apt-get update &&\
    apt-get install python-pip -y &&\
    pip install ansible==2.9.12 &&\
    apt-get install git -y

CMD ["ansible", "--version"]
