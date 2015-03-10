FROM node:0.10-slim

MAINTAINER Jaroslav Holub <jaroslav.holub@container-solutions.com>

RUN apt-get update && apt-get -y upgrade && apt-get -y install git bzip2 && apt-get clean && git clone https://github.com/hakimel/reveal.js.git /revealjs
RUN mkdir -p /revealjs/pres

WORKDIR /revealjs

RUN npm install -g grunt-cli && npm install

RUN sed -i Gruntfile.js -e "s/files: \[ 'index\.html'\]/files: [ 'pres\/**' ]/"
ADD index.html /revealjs/
ADD custom.css /revealjs/css/
ADD title.js /revealjs/plugin/

EXPOSE 8000 35729
CMD ["grunt", "serve"]
