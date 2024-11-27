#!/bin/bash

# Set the LICENSESDIR variable
LICENSESDIR='/opt/Altova/licenses'

# upgrade db if needed
/opt/Altova/MobileTogetherServer/bin/mobiletogetherserver upgradedb

# Verify license for MobileTogether Server
if ! /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver verifylicense; then

    # register with license server
    echo "Registering MobileTogether Server with License Server"
    /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver licenseserver licenseserver

    # assign license
    echo "Assigning license for MobileTogether Server"
    /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver assignlicense ${LICENSESDIR}/mobiletogetherserveradv.altova_licenses

    # accept EULA
    echo "Accepting EULA for MobileTogether Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver accepteula

fi

# start the server
/opt/Altova/MobileTogetherServer/bin/mobiletogetherserver debug
