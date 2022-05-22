FROM ubuntu:20.04

RUN mkdir /jenkins

WORKDIR /jenkins

CMD ["pwd"]
