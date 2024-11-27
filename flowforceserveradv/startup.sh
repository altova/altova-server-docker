#!/bin/bash

# Set the INSTANCEDIR variable
INSTANCEDIR="/var/opt/Altova/FlowForceServer/data"
TOOLSDIR=${INSTANCEDIR}'/tools/'
LICENSESDIR='/opt/Altova/licenses'

# Verify licenses for each server to ensure that registration and license assignment only happens once

# Verify license for FlowForce Server
if ! /opt/Altova/FlowForceServer2025/bin/flowforceserver verifylicense; then
    echo "Registering FlowForce Server with License Server"
    /opt/Altova/FlowForceServer2025/bin/flowforceserver licenseserver licenseserver
    echo "Assigning license for FlowForce Server"
    /opt/Altova/FlowForceServer2025/bin/flowforceserver assignlicense ${LICENSESDIR}/flowforceserveradv.altova_licenses
    echo "Accepting EULA for FlowForce Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/FlowForceServer2025/bin/flowforceserver accepteula
fi

# Verify license for DiffDog Server
if ! /opt/Altova/DiffDogServer2025/bin/diffdogserver verifylicense; then
    echo "Registering DiffDog Server with License Server"
    /opt/Altova/DiffDogServer2025/bin/diffdogserver licenseserver licenseserver
    echo "Assigning license for DiffDog Server"
    /opt/Altova/DiffDogServer2025/bin/diffdogserver assignlicense ${LICENSESDIR}/diffdogserver.altova_licenses
    echo "Accepting EULA for DiffDog Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/DiffDogServer2025/bin/diffdogserver accepteula
fi

# Verify license for MapForce Server
if ! /opt/Altova/MapForceServer2025/bin/mapforceserver verifylicense; then
    echo "Registering MapForce Server with License Server"
    /opt/Altova/MapForceServer2025/bin/mapforceserver licenseserver licenseserver
    echo "Assigning license for MapForce Server"
    /opt/Altova/MapForceServer2025/bin/mapforceserver assignlicense ${LICENSESDIR}/mapforceserveradv.altova_licenses
    echo "Accepting EULA for MapForce Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/MapForceServer2025/bin/mapforceserver accepteula
fi

# Verify license for StyleVision Server
if ! /opt/Altova/StyleVisionServer2025/bin/stylevisionserver verifylicense; then
    echo "Registering StyleVision Server with License Server"
    /opt/Altova/StyleVisionServer2025/bin/stylevisionserver licenseserver licenseserver
    echo "Assigning license for StyleVision Server"
    /opt/Altova/StyleVisionServer2025/bin/stylevisionserver assignlicense ${LICENSESDIR}/stylevisionserver.altova_licenses
    echo "Accepting EULA for StyleVision Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/StyleVisionServer2025/bin/stylevisionserver accepteula
fi

# Verify license for RaptorXML Server
if ! /opt/Altova/RaptorXMLServer2025/bin/raptorxmlserver verifylicense; then
    echo "Registering RaptorXML Server with License Server"
    /opt/Altova/RaptorXMLServer2025/bin/raptorxmlserver licenseserver licenseserver
    echo "Assigning license for RaptorXML Server"
    /opt/Altova/RaptorXMLServer2025/bin/raptorxmlserver assignlicense ${LICENSESDIR}/raptorxmlserver.altova_licenses
    echo "Accepting EULA for RaptorXML Server"
    echo "By using the accepteula command-line option in this script, you explicitly agree to the"
    echo "Altova Server Software License Agreement at https://www.altova.com/legal/server-software-eula"
    /opt/Altova/RaptorXMLServer2025/bin/raptorxmlserver accepteula
fi

# Start RaptorXML Server
/opt/Altova/RaptorXMLServer2025/bin/raptorxmlserver debug &

# call the FlowForce Server upgradedb to integrate the tools into the configuration
/opt/Altova/FlowForceServer2025/bin/flowforceserver upgradedb --datadir=${INSTANCEDIR} --integratetools

# Start FlowForce Server
/opt/Altova/FlowForceServer2025/bin/flowforceserver debug --datadir=${INSTANCEDIR} &
/opt/Altova/FlowForceServer2025/bin/flowforcewebserver debug --datadir=${INSTANCEDIR}
