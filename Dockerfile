# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install OpenSSH server
RUN apt-get update && apt-get install -y sudo bash clang-15 lld-15 socat cmake meson pkg-config wget unzip openssh-server
RUN mkdir /var/run/sshd && \
    echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config && \
    echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config && \
    echo 'root:rootpasswd' | chpasswd

RUN wget https://github.com/ps5-payload-dev/sdk/releases/latest/download/ps5-payload-sdk.zip
RUN unzip -d /opt ps5-payload-sdk.zip
RUN rm ps5-payload-sdk.zip

# Expose the SSH port
EXPOSE 22

RUN echo 'if [[ -n $SSH_CONNECTION ]] ; then' >> /etc/bash.bashrc && \
    echo '    echo "Defining PS5_PAYLOAD_SDK"' >> /etc/bash.bashrc && \
    echo '    export PS5_PAYLOAD_SDK=/opt/ps5-payload-sdk' >> /etc/bash.bashrc && \
    echo 'fi' >> /etc/bash.bashrc

# Start the SSH server
CMD ["/usr/sbin/sshd", "-D"]