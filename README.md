# PS5-Payload-SDK-Docker

Usage: Virtulised environment for developing Payloads. Connect to the container with VS Code via SSH and start developing.
Just for testing... 


## Dockerfile:

docker build -t ps5-payload-sdk .

docker run -d -t -p 2222:22 --name PS5-Payload-SDK ps5-payload-sdk

ssh root@localhost -p 2222    # passwd: rootpasswd