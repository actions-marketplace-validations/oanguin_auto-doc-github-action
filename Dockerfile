FROM alpine:3.10

LABEL "com.github.actions.name"="Auto Doc Generation"
LABEL "com.github.actions.description"="Auto generate documentation based on open api specifications"

RUN apk add --no-cache bash npm
RUN sudo npm install redoc-cli -g

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]