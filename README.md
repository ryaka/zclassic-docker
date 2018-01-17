## Introduction

*For the purposes of security, building the image yourself is highly suggested*

This is a Docker image for building and running a Zclassic node.

## Prerequisites

You will need Docker to use this. Installation instructions can be found
[here](https://docs.docker.com/engine/installation/)

## Usage

*Note: The instructions above name both the image and container zclassic. This
is arbitrary but assuming the user may be unfamiliar with Docker, this is
simplified*

In order to get a process up and running you will need to build the Docker
image and then run a container.

To build the image, run the following command:
```
# This should take a while to build. By default it uses all cores.
docker build -t zclassic .
```

To run a container after building the image, run the following command:
```
# This will automatically start up the node and sync with the network
docker run -it -d --name zclassic zclassic
```

### Backing up a wallet

By default a wallet will be automatically created when running the node.
In order to get backup this wallet, copy it from the container to your system.

To copy the wallet, run the following command:
```
docker cp zclassic:/root/.zclassic/wallet.dat <destination host directory>

# Example to copy it to ryaka's home directory
# docker cp zclassic:/root/.zclassic/wallet.dat /home/ryaka
```

### Running zclassic client commands

All the commands as detailed in the [zcash documentation](https://github.com/zcash/zcash/wiki/1.0-User-Guide) (applies for Zclassic) will work.

Below are some examples:
```
# Print out help for available commands
docker exec -it zclassic zcash-cli help
```

```
# Print out general info such as balance, synced block height, difficulty, fees, etc
docker exec -it zclassic zcash-cli getinfo
```

```
# Create a t-addr
docker exec -it zclassic getnewaddress
```

### Stopping the process

To stop the container, run the following command:
```
docker stop zclassic
```

### Cleaning up

*Note: You may want to backup the wallet if you've used it to create any
transactions*

In order to clean everything up, run the following:
```
# Stop the container
docker stop zclassic

# Remove the container
docker rm zclassic

# Remove the image
docker rmi zclassic
```
