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

# Configure SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' /etc/ssh/sshd_config

# Allow for key-based authentication
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# Add a custom SSH configuration for user-based routing
COPY sshd_config /etc/ssh/sshd_config
COPY forward_to_pod /usr/local/bin/forward_to_pod
RUN chmod +x /usr/local/bin/forward_to_pod

# Expose SSH port
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
