# syntax=docker/dockerfile:1
FROM ubuntu:24.04

ARG AltovaServerURL='https://cdn.sw.altova.com/v2025/multi-lingual/'
ARG licenseserverServerInstaller='licenseserver-3.16-ubuntu.deb'

# install app dependencies
RUN apt-get update 
RUN apt-get install -y wget ca-certificates libidn12 libgssapi-krb5-2 libfontconfig1 libqt5gui5 libqt5widgets5 libldap-2.4 tzdata gpg default-jre sqlite3

# install app
RUN wget ${AltovaServerURL}${licenseserverServerInstaller}
RUN dpkg --install ${licenseserverServerInstaller}

# clean up installer files
RUN rm ${licenseserverServerInstaller}

# copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# final configuration
EXPOSE 8088
EXPOSE 35355
CMD ["/startup.sh"]
