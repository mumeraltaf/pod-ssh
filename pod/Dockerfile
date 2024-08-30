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

# Expose the SSH port
EXPOSE 22

# Start SSH service
#CMD ["/usr/sbin/sshd", "-D"]


# Copy the entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh



########################

USER root

#
# Systemd installation
#
RUN apt-get update &&                            \
    apt-get install -y --no-install-recommends   \
            systemd                              \
            systemd-sysv                         \
            libsystemd0                          \
            ca-certificates                      \
            dbus                                 \
            iptables                             \
            iproute2                             \
            kmod                                 \
            locales                              \
            sudo                                 \
            udev &&                              \
                                                 \
    # Prevents journald from reading kernel messages from /dev/kmsg
    echo "ReadKMsg=no" >> /etc/systemd/journald.conf &&               \
                                                                      \
    # Housekeeping
    apt-get clean -y &&                                               \
    rm -rf                                                            \
       /var/cache/debconf/*                                           \
       /var/lib/apt/lists/*                                           \
       /var/log/*                                                     \
       /tmp/*                                                         \
       /var/tmp/*                                                     \
       /usr/share/doc/*                                               \
       /usr/share/man/*                                               \
       /usr/share/local/* &&                                          \
                                                                      \
    # Create default 'admin/admin' user
    useradd --create-home --shell /bin/bash admin && echo "admin:admin" | chpasswd && adduser admin sudo

# Disable systemd services/units that are unnecessary within a container.
RUN systemctl mask systemd-udevd.service \
                   systemd-udevd-kernel.socket \
                   systemd-udevd-control.socket \
                   systemd-modules-load.service \
                   sys-kernel-debug.mount \
                   sys-kernel-tracing.mount

# Make use of stopsignal (instead of sigterm) to stop systemd containers.
STOPSIGNAL SIGRTMIN+3




# Docker install
RUN apt-get update && apt-get install --no-install-recommends -y \
       apt-transport-https \
       ca-certificates \
       curl \
       gnupg-agent \
       software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88

RUN add-apt-repository \
       "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
       $(lsb_release -cs) \
       stable"
RUN apt-get update && apt-get install --no-install-recommends -y docker-ce docker-ce-cli docker-compose-plugin containerd.io

########################



# Set the entrypoint
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]