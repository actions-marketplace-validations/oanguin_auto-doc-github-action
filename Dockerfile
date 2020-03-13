FROM alpine:3.10

LABEL "com.github.actions.name"="Auto Doc Generation"
LABEL "com.github.actions.description"="Auto generate documentation based on open api specifications"

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]