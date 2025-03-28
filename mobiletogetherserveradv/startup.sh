#!/bin/bash

# Set the LICENSESDIR variable
LICENSESDIR='/opt/Altova/licenses'

# upgrade db if needed
/opt/Altova/MobileTogetherServer/bin/mobiletogetherserver upgradedb

# Before we begin, we need to wait for the License Server to be ready
sleep 10

# Verify license for MobileTogether Server
if ! /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver verifylicense; then

    # register with license server
    echo "Registering MobileTogether Server with License Server"
    until /opt/Altova/MobileTogetherServer/bin/mobiletogetherserver licenseserver licenseserver; do
        echo "Waiting for License Server to be ready..."
        sleep 10
    done

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
