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

# Configure SSH for key-based authentication
RUN mkdir -p /home/umer/.ssh && chown umer:umer /home/umer/.ssh && chmod 700 /home/umer/.ssh
COPY authorized_keys /home/umer/.ssh/authorized_keys
RUN chown umer:umer /home/umer/.ssh/authorized_keys && chmod 600 /home/umer/.ssh/authorized_keys

## Set SSH to allow the user to login
#RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
#RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
#RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
#RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
#RUN echo "AllowUsers umer" >> /etc/ssh/sshd_config

COPY sshd_config /etc/ssh/sshd_config


# Expose the SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]