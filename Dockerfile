FROM nginx:1.19

#LABEL org.opencontainers.image.source="https://github.com/${{ github.repository }}"

ARG REPO_URL

LABEL org.opencontainers.image.source=$REPO_URL

RUN printf '%s\n' \
    'deb http://archive.debian.org/debian buster main contrib non-free' \
    'deb http://archive.debian.org/debian buster-updates main contrib non-free' \
    'deb http://archive.debian.org/debian-security buster/updates main contrib non-free' \
    > /etc/apt/sources.list \
 && apt-get -o Acquire::Check-Valid-Until=false update \
 && apt-get install -y --no-install-recommends \
    telnet \
    ftp \
    vsftpd \
    apache2 \
 && rm -rf /var/lib/apt/lists/*

CMD ["nginx", "-g", "daemon off;"]
