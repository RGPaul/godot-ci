# ----------------------------------------------------------------------------------------------------------------------
# The MIT License (MIT)
#
# Copyright (c) 2020 Ralph-Gordon Paul. All rights reserved.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated 
# documentation files (the "Software"), to deal in the Software without restriction, including without limitation the 
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
# persons to whom the Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial portions of the 
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE 
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR 
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# ----------------------------------------------------------------------------------------------------------------------

FROM debian:buster
LABEL author="development@rgpaul.com"

ENV GODOT_VERSION "3.2.1"
ENV ANDROID_CL_TOOLS "commandlinetools-linux-6200805_latest.zip"
ENV ANDROID_HOME "/opt/android/sdk"
ENV ANDROID_NDK_VERSION "r21b"
ENV ANDROID_NDK_PATH "/opt/android/android-ndk-${ANDROID_NDK_VERSION}"
ENV PATH="$PATH:/opt/android/sdk/tools/bin:/opt/android/sdk/platform-tools"

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    openjdk-11-jdk \
    openssl \
    python \
    python-openssl \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Install Android SDK / NDK
RUN mkdir -p /opt/android/sdk && cd /opt/android/sdk \
    && curl -OL https://dl.google.com/android/repository/${ANDROID_CL_TOOLS} \
    && unzip ${ANDROID_CL_TOOLS} \
    && rm ${ANDROID_CL_TOOLS} \
    && yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses \
    && sdkmanager --sdk_root=${ANDROID_HOME} platform-tools \
    && cd /opt/android \
    && curl -sSOL "https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip" \
    && unzip -q -o android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip \
    && rm android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip

RUN curl -OL https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip \
    && curl -OL  https://downloads.tuxfamily.org/godotengine/${GODOT_VERSION}/Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mkdir ~/.cache \
    && mkdir -p ~/.config/godot \
    && mkdir -p ~/.local/share/godot/templates/${GODOT_VERSION}.stable \
    && unzip Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip \
    && mv Godot_v${GODOT_VERSION}-stable_linux_headless.64 /usr/local/bin/godot \
    && rm -f Godot_v${GODOT_VERSION}-stable_linux_headless.64.zip \
    && unzip Godot_v${GODOT_VERSION}-stable_export_templates.tpz \
    && mv templates/* ~/.local/share/godot/templates/${GODOT_VERSION}.stable \
    && rm -f Godot_v${GODOT_VERSION}-stable_export_templates.tpz

COPY editor_settings-?.tres /root/.config/godot/
