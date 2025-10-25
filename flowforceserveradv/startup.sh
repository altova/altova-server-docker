#!/bin/bash

# Set the INSTANCEDIR variable
INSTANCEDIR="/var/opt/Altova/FlowForceServer/data"
TOOLSDIR=${INSTANCEDIR}'/tools/'
LICENSESDIR='/opt/Altova/licenses'

# Verify licenses for each server to ensure that registration and license assignment only happens once
# Before we begin, we need to wait for the License Server to be ready
sleep 10

# Verify license for FlowForce Server
if ! /opt/Altova/FlowForceServer2026/bin/flowforceserver verifylicense; then
    echo "Registering FlowForce Server with License Server"
    until /opt/Altova/FlowForceServer2026/bin/flowforceserver licenseserver licenseserver; do
        echo "Waiting for License Server to be ready..."
        sleep 10
    done
    echo "Assigning license for FlowForce Server"
    /opt/Altova/FlowForceServer2026/bin/flowforceserver assignlicense ${LICENSESDIR}/flowforceserveradv.altova_licenses
    echo "Accepting EULA for FlowForce Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/FlowForceServer2026/bin/flowforceserver accepteula
fi

# Verify license for DiffDog Server
if ! /opt/Altova/DiffDogServer2026/bin/diffdogserver verifylicense; then
    echo "Registering DiffDog Server with License Server"
    /opt/Altova/DiffDogServer2026/bin/diffdogserver licenseserver licenseserver
    echo "Assigning license for DiffDog Server"
    /opt/Altova/DiffDogServer2026/bin/diffdogserver assignlicense ${LICENSESDIR}/diffdogserver.altova_licenses
    echo "Accepting EULA for DiffDog Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/DiffDogServer2026/bin/diffdogserver accepteula
fi

# Verify license for MapForce Server
if ! /opt/Altova/MapForceServer2026/bin/mapforceserver verifylicense; then
    echo "Registering MapForce Server with License Server"
    /opt/Altova/MapForceServer2026/bin/mapforceserver licenseserver licenseserver
    echo "Assigning license for MapForce Server"
    /opt/Altova/MapForceServer2026/bin/mapforceserver assignlicense ${LICENSESDIR}/mapforceserveradv.altova_licenses
    echo "Accepting EULA for MapForce Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/MapForceServer2026/bin/mapforceserver accepteula
fi

# Verify license for StyleVision Server
if ! /opt/Altova/StyleVisionServer2026/bin/stylevisionserver verifylicense; then
    echo "Registering StyleVision Server with License Server"
    /opt/Altova/StyleVisionServer2026/bin/stylevisionserver licenseserver licenseserver
    echo "Assigning license for StyleVision Server"
    /opt/Altova/StyleVisionServer2026/bin/stylevisionserver assignlicense ${LICENSESDIR}/stylevisionserver.altova_licenses
    echo "Accepting EULA for StyleVision Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/StyleVisionServer2026/bin/stylevisionserver accepteula
fi

# Verify license for RaptorXML Server
if ! /opt/Altova/RaptorXMLServer2026/bin/raptorxmlserver verifylicense; then
    echo "Registering RaptorXML Server with License Server"
    /opt/Altova/RaptorXMLServer2026/bin/raptorxmlserver licenseserver licenseserver
    echo "Assigning license for RaptorXML Server"
    /opt/Altova/RaptorXMLServer2026/bin/raptorxmlserver assignlicense ${LICENSESDIR}/raptorxmlserver.altova_licenses
    echo "Accepting EULA for RaptorXML Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/RaptorXMLServer2026/bin/raptorxmlserver accepteula
fi

# Start RaptorXML Server
/opt/Altova/RaptorXMLServer2026/bin/raptorxmlserver debug &

# call the FlowForce Server upgradedb to integrate the tools into the configuration
/opt/Altova/FlowForceServer2026/bin/flowforceserver upgradedb --datadir=${INSTANCEDIR} --integratetools

# Start FlowForce Server
/opt/Altova/FlowForceServer2026/bin/flowforceserver debug --datadir=${INSTANCEDIR} &
/opt/Altova/FlowForceServer2026/bin/flowforcewebserver debug --datadir=${INSTANCEDIR}
