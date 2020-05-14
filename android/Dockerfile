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

FROM rgpaul/godot-ci:3.2.1
LABEL author="development@rgpaul.com"

ENV ANDROID_CL_TOOLS "commandlinetools-linux-6200805_latest.zip"
ENV ANDROID_HOME "/opt/android/sdk"

# adds adb and jarsigner to the PATH
ENV PATH="$PATH:/opt/android/sdk/tools/bin:/opt/android/sdk/platform-tools"

USER root

# Install OpenJDK
RUN apt-get update && apt-get install -y --no-install-recommends \
    openjdk-11-jdk \
    && rm -rf /var/lib/apt/lists/*

# Install Android SDK
RUN mkdir -p /opt/android/sdk && cd /opt/android/sdk \
    && curl -OL https://dl.google.com/android/repository/${ANDROID_CL_TOOLS} \
    && unzip ${ANDROID_CL_TOOLS} \
    && rm ${ANDROID_CL_TOOLS} \
    && yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses \
    && sdkmanager --sdk_root=${ANDROID_HOME} platform-tools

# Copy the editor_settings.tres that contains setup adb and jarsigner paths
COPY editor_settings.tres /root/.godot/
