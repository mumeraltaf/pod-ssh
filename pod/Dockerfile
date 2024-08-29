# Use an official Ubuntu base image
FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    bash \
    nano \
    curl \
    && rm -rf /var/lib/apt/lists/*



# Create the SSH privilege separation directory
RUN mkdir -p /run/sshd && chmod 0755 /run/sshd

# Create a user with a home directory
RUN useradd -m -s /bin/bash umer

# Set a password for the user (optional, for debugging)
RUN echo 'umer:userApassword' | chpasswd

# Allow the user to use sudo (optional)
RUN usermod -aG sudo umer

COPY sshd_config /etc/ssh/sshd_config
# Allow for key-based authentication
RUN mkdir -p /umer/.ssh && chmod 700 /umer/.ssh
COPY authorized_keys /umer/.ssh/authorized_keys
RUN chmod 600 /umer/.ssh/authorized_keys

# Expose the SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]