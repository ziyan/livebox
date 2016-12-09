FROM busybox

ADD . /

VOLUME ["/tmp", "/data"]

EXPOSE 1935

WORKDIR /data

USER www-data

ENTRYPOINT ["/bin/entrypoint"]
