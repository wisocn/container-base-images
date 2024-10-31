# Use Azul Zulu OpenJDK 17 JRE as the source for Java Runtime Environment
FROM azul/zulu-openjdk:11-jre-headless-latest AS jre-source

# Start with the latest Ubuntu image for compatibility and tool availability
FROM ubuntu:noble

# Set timezone environment variable
ENV TZ=UTC

# Update package lists and install essential packages and utilities
RUN apt-get update && \
    apt-get install -y tzdata \
    gnupg \
    locales \
    curl \
    bash \
    dnsutils \
    less \
    libxml2-utils \
    lsof \
    net-tools \
    htop \
    procps \
    jattach && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy Java Runtime Environment from the source image
COPY --from=jre-source /usr/lib/jvm /usr/lib/jvm

# Set JAVA_HOME environment variable for Java installation path
ENV JAVA_HOME=/usr/lib/jvm/zulu11
# Add Java binaries to PATH for easy command-line access
ENV PATH="$JAVA_HOME/bin:$PATH"

# Create a system group 'appuser' and user for running applications securely
RUN addgroup --system appuser --gid 1001 && \
    adduser --home "/app" --system appuser --ingroup appuser --uid 1001 \
    # Create a logs directory and set permissions
    && mkdir /app/logs && chown appuser:appuser /app/logs

# Copy the test-image script to the binary directory
COPY test-image.sh /usr/local/bin/

# install https java checkup program
COPY jenvtest.class /usr/local/share/jenvtest.class

# COPY run-java.sh to /usr/local/bin
COPY run-java.sh /usr/local/bin/

# Execute the test script to verify image setup
RUN /usr/local/bin/test-image.sh

# Create a symbolic link for backward compatibility with legacy configurations
RUN ln -s /app /bl

# Set the default user to 'appuser' for security
USER 1001

# Define volumes for application data and temporary files
VOLUME /app
VOLUME /tmp

# Set the default working directory
WORKDIR /app

# Define the entry point for the container, starting the Java application
ENTRYPOINT ["/usr/local/bin/run-java.sh"]