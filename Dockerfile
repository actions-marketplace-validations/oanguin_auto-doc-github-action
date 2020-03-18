FROM node:8.10.0-alpine

LABEL "com.github.actions.name"="Auto Doc Generation"
LABEL "com.github.actions.description"="Auto generate documentation based on open api specifications"

RUN apk add --no-cache bash
RUN npm config set unsafe-perm true
RUN npm install redoc-cli -g

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]