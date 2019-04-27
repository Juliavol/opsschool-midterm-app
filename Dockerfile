FROM alpine:3.9
LABEL maintainer="julia"
WORKDIR /src
EXPOSE 5000
ENTRYPOINT [ "npm" ]
CMD [ "start" ]
RUN apk update && apk add nodejs npm
COPY foaas/ /src
RUN npm install