FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
COPY loop.sh /loop.sh
RUN <<EOF
    apt-get update
    apt-get install -y apache2 php php-xdebug git grc
    echo "xdebug.start_with_request=yes" >> xdebug.ini
    echo "xdebug.mode=debug" >> xdebug.ini
EOF
CMD ["/loop.sh"]
