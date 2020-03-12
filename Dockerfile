FROM alpine:3.9.5

LABEL "com.github.actions.name"="Auto Doc Generation"
LABEL "com.github.actions.description"="Auto generate documentation based on open api specifications"

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]