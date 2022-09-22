FROM postgres

COPY scripts/*.sh /docker-entrypoint-initdb.d/

COPY init/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

COPY init/.bashrc /root/.bashrc

# RUN apt update && apt install vim -y