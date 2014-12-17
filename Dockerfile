FROM node:0.10-slim

MAINTAINER Adrian Mouat <adrian@adrianmouat.com>

RUN git clone https://github.com/ContainerSolutions/reveal.js.git /revealjs
RUN mkdir -p /revealjs/pres

WORKDIR /revealjs

RUN npm install -g grunt-cli && npm install

RUN sed -i Gruntfile.js -e 's/port: port,/port: port, hostname: "", livereload: true,/'
RUN sed -i Gruntfile.js -e "s/files: \[ 'index\.html' \],/files: [ 'pres\/**' ],/"
ADD index.html /revealjs/
ADD custom.css /revealjs/css/
ADD title.js /revealjs/plugin/

EXPOSE 8000
CMD ["grunt", "serve"]
