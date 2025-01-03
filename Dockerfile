FROM ubuntu

MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>
ENTRYPOINT ["/usr/src/app/image-graph.sh"]
CMD [""]

RUN apt-get update && apt-get -y install ruby-sinatra graphviz
RUN gem install --no-document docker-api
RUN dot -c

ADD . /usr/src/app/
WORKDIR /usr/src/app/
