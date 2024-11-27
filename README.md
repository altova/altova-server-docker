# Altova Server Platform in Docker

This project provides an easy way to install and run the various components of the **[Altova Server Platform](https://www.altova.com/server-platform)** in a Docker environment. It includes configuration files and instructions to set up the server products with minimal effort, leveraging Docker Compose.

## About the Altova Server Platform

The [Altova Server Platform](https://www.altova.com/server-platform) automates high-performance data processing, integration workflows, and other enterprise-level tasks. It includes the following components:

- **[FlowForce Server](https://www.altova.com/flowforceserver)**: A powerful workflow engine for scheduling and automating data processing and integration tasks.
- **[MapForce Server](https://www.altova.com/mapforce-server)**: Automates data mappings and aggregations for XML, JSON, databases, EDI, Excel, and more.
- **[StyleVision Server](https://www.altova.com/stylevision-server)**: Automates business report generation in formats such as HTML, PDF, and Word/OpenXML.
- **[RaptorXML+XBRL Server](https://www.altova.com/raptorxml)**: A hyper-fast XML, JSON, and XBRL validator and processor.
- **[DiffDog Server](https://www.altova.com/diffdog-server)**: Automates file and directory comparisons with high-performance diff report generation.
- **[MobileTogether Server](https://www.altova.com/mobiletogether-server)**: The back-end hub for mobile apps built with Altova MobileTogether Designer.

Each of these products can be used individually or in combination, with FlowForce Server acting as a central workflow automation hub.

## Quick Start

This project includes Docker configurations to help you quickly deploy the Altova Server Platform components. Follow the steps below to set up your Docker environment.

### Prerequisites

- Docker and Docker Compose installed on your system.
- Valid license files for the Altova server products that you have already purchase, or willingness to request free 30-day evaluation keys for the servers you want to test via the Altova LicenseServer.

### Setup and Installation

1. Clone this repository to your local system:

```bash
   git clone https://github.com/altova/altova-server-docker.git
   cd altova-server-docker
```

2. **License Files**:  
	
	The various `.altova_licenses` files included in this repository are **placeholders**. Replace them with your own license files if you have already purchased licenses. If not, you can request free 30-day evaluation keys directly through the admin web interface of LicenseServer after deploying the containers.

3. Start the containers using Docker Compose:

```bash
docker compose up -d
```

4. Optionally, if you need to be requesting eval licenses:
	
	Once the containers are up and running, access the **Altova LicenseServer** through your web browser. Use the LicenseServer admin interface to request free 30-day evaluation keys for the Altova server products you wish to test.

### Accessing the Components

Each server component will be available on its respective port. You can adjust ports and other configurations in the `compose.yaml` file as needed. For detailed information about how to use each product, refer to the respective manuals on the Altova website:

- [FlowForce Server 2025 Advanced Edition](https://www.altova.com/manual/FlowForceServer/FlowForceServerAdvanced/)
- [MapForce Server 2025 Advanced Edition](https://www.altova.com/manual/MapForceServer/MapForceServerAdvanced/)
- [StyleVision Server 2025](https://www.altova.com/manual/StyleVisionServer/)
- [RaptorXML+XBRL Server 2025](https://www.altova.com/manual/RaptorXML/raptorxmlxbrlserver/)
- [DiffDog Server 2025](https://www.altova.com/manual/DiffDogServer/)
- [MobileTogether Server Advanced Edition](https://www.altova.com/manual/MobileTogether/mobiletogetherserveradvanced/)
- [Altova LicenseServer](https://www.altova.com/manual/AltovaLicenseServer/)

## Customizing Your Deployment

- Modify the `compose.yaml` file to enable or disable specific components.
- Edit the Dockerfiles in the respective subdirectories to include additional dependencies or settings.

## Troubleshooting

- **License Issues**: Ensure you have placed valid license files replacing the respective `.altova_licenses` placeholders or connected to the LicenseServer to request evaluation keys.
- **Network Conflicts**: If ports conflict with other services on your machine, update the `ports` section in `compose.yaml`.
