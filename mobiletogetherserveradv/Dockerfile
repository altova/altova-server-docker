# syntax=docker/dockerfile:1
FROM ubuntu:24.04

ARG MobileTogetherServerURL='https://cdn.sw.altova.com/MT_10.0/'
ARG MobileTogetherServerInstaller='mobiletogetherserveradv-10.0-ubuntu.deb'

# important directories
ARG LICENSESDIR='/opt/Altova/licenses'

# install app dependencies
RUN apt-get update 
RUN apt-get install -y wget ca-certificates libidn12 libgssapi-krb5-2 libfontconfig1 libqt5gui5 libqt5widgets5 libldap-2.4 tzdata gpg default-jre sqlite3 rsyslog

# install app
RUN wget ${MobileTogetherServerURL}${MobileTogetherServerInstaller}
RUN dpkg --install ${MobileTogetherServerInstaller}

# clean up installer files
RUN rm ${MobileTogetherServerInstaller}

# copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# create log directory
RUN mkdir -p /var/log
RUN mkdir -p /var/log/Altova

# set permissions
RUN chmod -R 755 /var/log/Altova

# copy license files
RUN mkdir -p ${LICENSESDIR}
COPY mobiletogetherserveradv.altova_licenses ${LICENSESDIR}/mobiletogetherserveradv.altova_licenses

# final configuration
EXPOSE 8083
EXPOSE 8085
CMD ["/startup.sh"]
