# This Dockerfile creates a static build image for CI
FROM openjdk:11-jdk
LABEL maintainer silentnuke <kostiantyn@silentnuke.com>

ENV ANDROID_COMPILE_SDK "30"
ENV ANDROID_BUILD_TOOLS "30.0.2"
# Version from https://developer.android.com/studio#cmdline-tools
ENV ANDROID_SDK_TOOLS "7583922_latest"

ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV ANDROID_HOME /opt/android-sdk-linux

# install OS packages
RUN apt-get --quiet update --yes
RUN apt-get --quiet install --yes wget apt-utils tar unzip lib32stdc++6 lib32z1 vim-common
# install Android SDK
RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}.zip -O android-commandline-tools.zip \
    && mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools \
    && unzip -q android-commandline-tools.zip -d /tmp/ \
    && mv /tmp/cmdline-tools/ ${ANDROID_SDK_ROOT}/cmdline-tools/latest \
    && rm android-commandline-tools.zip && ls -la ${ANDROID_SDK_ROOT}/cmdline-tools/latest/
ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/platform-tools:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin

RUN yes | sdkmanager --licenses
RUN yes | sdkmanager "platform-tools"
RUN yes | sdkmanager \
    "platforms;android-${ANDROID_COMPILE_SDK}" \
    "build-tools;${ANDROID_BUILD_TOOLS}" \
    "extras;android;m2repository" \
    "extras;google;m2repository" \
    "extras;google;google_play_services" \
    "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2"
