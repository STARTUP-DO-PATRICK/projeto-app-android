FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ANDROID_SDK_ROOT=/opt/android-sdk
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$PATH:/opt/gradle/bin:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools

RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-11-jdk wget unzip curl git ca-certificates zip unzip \
    lib32stdc++6 lib32z1 libc6-i386 && \
    rm -rf /var/lib/apt/lists/*

# Install Gradle (binary distribution)
ENV GRADLE_VERSION=8.2.1
RUN mkdir -p /opt/gradle && \
    wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip && \
    unzip -q /tmp/gradle.zip -d /opt/gradle && \
    rm /tmp/gradle.zip && \
    ln -s /opt/gradle/gradle-${GRADLE_VERSION} /opt/gradle/latest

# Install Android commandline tools (use sdkmanager to install cmdline-tools to ensure correct layout)
RUN mkdir -p ${ANDROID_SDK_ROOT} && \
    cd /tmp && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip -O cmdline-tools.zip && \
    unzip -q cmdline-tools.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools-temp && \
    rm cmdline-tools.zip && \
    mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools-temp/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest || true && \
    rm -rf ${ANDROID_SDK_ROOT}/cmdline-tools-temp

ENV ANDROID_HOME=${ANDROID_SDK_ROOT}

# Ensure JAVA_HOME is set for sdkmanager; add diagnostics and retry installation to reduce transient failures
RUN echo "[docker] java version:" && java -version || true && \
    echo "[docker] ANDROID_SDK_ROOT contents before sdkmanager:" && ls -la ${ANDROID_SDK_ROOT} || true && \
    echo "[docker] sdkmanager path exists?" && ls -la ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin || true && \
    echo "[docker] sdkmanager --version:" && ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --version || true && \
    echo "[docker] environment vars:" && env || true && \
    echo "[docker] connectivity test to dl.google.com:" && curl -I https://dl.google.com || true

RUN set -e; \
        export JAVA_HOME=${JAVA_HOME}; \
        ATTEMPTS=0; \
        until [ $ATTEMPTS -ge 3 ]; do \
            echo "[docker] accepting licenses (attempt $((ATTEMPTS+1)))"; \
            yes | ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --licenses && break || true; \
            ATTEMPTS=$((ATTEMPTS+1)); sleep 3; \
        done; \
        ATTEMPTS=0; \
        until [ $ATTEMPTS -ge 3 ]; do \
            echo "[docker] installing platform-tools/platforms/build-tools (attempt $((ATTEMPTS+1)))"; \
            ${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin/sdkmanager --sdk_root=${ANDROID_SDK_ROOT} --verbose "platform-tools" "platforms;33" "build-tools;33.0.2" && break || true; \
            ATTEMPTS=$((ATTEMPTS+1)); sleep 5; \
        done

# Create workspace dir
WORKDIR /workspace

# Copy entrypoint and scripts
COPY scripts/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
