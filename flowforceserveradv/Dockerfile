# syntax=docker/dockerfile:1
FROM ubuntu:24.04

# UTF-8 locale
ARG LocaleEnUsUTF8='en_US.UTF-8'

# location of the Altova Server installers
ARG AltovaServerURL='https://cdn.sw.altova.com/v2025/multi-lingual/'

# installer names
ARG FlowForceServerInstaller='flowforceserveradv-2025-ubuntu.deb'
ARG DiffDogServerInstaller='diffdogserver-2025-ubuntu.deb'
ARG MapForceServerInstaller='mapforceserveradv-2025-ubuntu.deb'
ARG StyleVisionServerInstaller='stylevisionserver-2025-ubuntu.deb'
ARG RaptorXMLServerInstaller='raptorxmlserver-2025-ubuntu.deb'

# important directories
ARG INSTANCEDIR='/var/opt/Altova/FlowForceServer/data'
ARG APPDATADIR='/var/opt/Altova/FlowForceServer2025'
ARG INSTALLDIR='/opt/Altova/FlowForceServer2025'
ARG LICENSESDIR='/opt/Altova/licenses'
ARG TOOLSDIR1=${INSTALLDIR}'/tools/'
ARG TOOLSDIR2=${INSTANCEDIR}'/tools/'

# Environment variables
ENV INSTANCEDIR=${INSTANCEDIR}
ENV APPDATADIR=${APPDATADIR}
ENV INSTALLDIR=${INSTALLDIR}
ENV LANG=${LocaleEnUsUTF8}
ENV LC_ALL=${LocaleEnUsUTF8}

# install app dependencies
RUN apt-get update 
RUN apt-get install -y wget ca-certificates libidn12 libgssapi-krb5-2 libfontconfig1 libqt5gui5 libqt5widgets5 libldap-2.4 tzdata gpg default-jre sqlite3 rsyslog python3

# download app installers (commented out because we're copying them from the host instead)
RUN wget ${AltovaServerURL}${FlowForceServerInstaller}
RUN wget ${AltovaServerURL}${DiffDogServerInstaller}
RUN wget ${AltovaServerURL}${MapForceServerInstaller}
RUN wget ${AltovaServerURL}${StyleVisionServerInstaller}
RUN wget ${AltovaServerURL}${RaptorXMLServerInstaller}

# install app
RUN dpkg --install ${FlowForceServerInstaller}
RUN dpkg --install ${DiffDogServerInstaller}
RUN dpkg --install ${MapForceServerInstaller}
RUN dpkg --install ${StyleVisionServerInstaller}
RUN dpkg --install ${RaptorXMLServerInstaller}

# clean up installer files
RUN rm ${FlowForceServerInstaller}
RUN rm ${DiffDogServerInstaller}
RUN rm ${MapForceServerInstaller}
RUN rm ${StyleVisionServerInstaller}
RUN rm ${RaptorXMLServerInstaller}

# copy startup script
COPY startup.sh /startup.sh
RUN chmod +x /startup.sh

# create log directory
RUN mkdir -p /var/log/Altova/RaptorXMLServer2025

# create tools directory for FlowForce Server
# RUN mkdir -p ${TOOLSDIR1}
# RUN mkdir -p ${TOOLSDIR2}

# set permissions
RUN chmod -R 755 /var/log/Altova

# copy flowforce server configuration files
COPY flowforce.ini /var/opt/Altova/FlowForceServer2025/flowforce.ini
COPY flowforceweb.ini /var/opt/Altova/FlowForceServer2025/flowforceweb.ini

# copy raptorxml server configuration file
COPY server_config.xml /opt/Altova/RaptorXMLServer2025/etc/server_config.xml

# copy license files
RUN mkdir -p ${LICENSESDIR}
COPY flowforceserveradv.altova_licenses ${LICENSESDIR}/flowforceserveradv.altova_licenses
COPY diffdogserver.altova_licenses ${LICENSESDIR}/diffdogserver.altova_licenses
COPY mapforceserveradv.altova_licenses ${LICENSESDIR}/mapforceserveradv.altova_licenses
COPY stylevisionserver.altova_licenses ${LICENSESDIR}/stylevisionserver.altova_licenses
COPY raptorxmlserver.altova_licenses ${LICENSESDIR}/raptorxmlserver.altova_licenses

# copy tools to INSTALLDIR
RUN cp /opt/Altova/MapForceServer2025/etc/*.tool ${TOOLSDIR1}
RUN cp /opt/Altova/StyleVisionServer2025/etc/*.tool ${TOOLSDIR1}
RUN cp /opt/Altova/RaptorXMLServer2025/etc/*.tool ${TOOLSDIR1}

# create flowforce server database and INSTANCEDIR
RUN /opt/Altova/FlowForceServer2025/bin/flowforceserver initdb --datadir=${INSTANCEDIR}

# copy tools to INSTANCEDIR
RUN cp /opt/Altova/MapForceServer2025/etc/*.tool ${TOOLSDIR2}
RUN cp /opt/Altova/StyleVisionServer2025/etc/*.tool ${TOOLSDIR2}
RUN cp /opt/Altova/RaptorXMLServer2025/etc/*.tool ${TOOLSDIR2}

# update flowforce server database and integrate tools
RUN /opt/Altova/FlowForceServer2025/bin/flowforceserver upgradedb --datadir=${INSTANCEDIR} --integratetools

# final configuration
EXPOSE 8082
EXPOSE 4646
EXPOSE 8087
EXPOSE 29800

CMD ["/startup.sh"]
