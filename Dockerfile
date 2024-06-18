FROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive
COPY loop.sh /loop.sh
RUN <<EOF
    apt-get update
    apt-get install -y apache2 php
EOF
CMD /loop.sh
