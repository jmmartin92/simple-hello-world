FROM node:18.20.4-alpine3.20
LABEL email="jmmartin92@hotmail.com"

# could using reduce image and without OS
# shouldn't use RUN apk -y as you don't know what is being update
# use multi-stage builds to reduce size of image

RUN deluser --remove-home node \
    && addgroup -g 1000 -S myapp \
    && adduser -S -D -u 1000 1000 myapp

WORKDIR /opt/app

RUN chown -R 1000:1000 /opt/app/ 

COPY --chown=1000:1000 package.json .
COPY --chown=1000:1000 server.js .

COPY htmlfiles ./htmlfiles

RUN npm install
# Remove npm as has vulnerability
RUN rm -fr /usr/local/lib/node_modules/npm


EXPOSE 8000
# Change to non-root user
USER 1000

CMD [ "server.js" ]
ENTRYPOINT [ "node" ]


