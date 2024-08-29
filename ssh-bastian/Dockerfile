# Use an official Ubuntu base image
FROM ubuntu:24.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    openssh-server \
    openssh-client \
    curl \
    bash \
    && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl \
    && rm kubectl

# Create SSH directory and set permissions
RUN mkdir /var/run/sshd

# Set the root password (optional, for debugging)
RUN echo 'root:rootpassword' | chpasswd

# Allow for key-based authentication
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Add a custom SSH configuration for user-based routing
COPY sshd_config /etc/ssh/sshd_config
COPY forward_to_pod /usr/local/bin/forward_to_pod
RUN chmod +x /usr/local/bin/forward_to_pod




#add umer user
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


# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
