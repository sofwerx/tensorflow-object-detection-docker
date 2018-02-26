FROM gcr.io/tensorflow/tensorflow:1.5.0-devel
RUN apt-get update && apt-get install -y \
  git \
  nano \
  vim \
  wget


# change to home dir
WORKDIR ~/

# create android dir and cd into android
RUN mkdir -p /android
WORKDIR /android

# initiate sdk version
ENV ANDROID_SDK_VERSION=r25.2.3

# using the version no above, pull the files
RUN wget -q https://dl.google.com/android/repository/tools_${ANDROID_SDK_VERSION}-linux.zip
RUN yes | unzip -q tools_${ANDROID_SDK_VERSION}-linux.zip
RUN rm tools_${ANDROID_SDK_VERSION}-linux.zip

# initiate ndk version
ENV ANDROID_NDK_VERSION r14b

# using the version no above, pull the files
RUN wget -q https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
RUN yes | unzip -q android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip
RUN rm android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip

# set the environmental variables
ENV ANDROID_HOME=/android
ENV ANDROID_NDK_HOME=/android/android-ndk-${ANDROID_NDK_VERSION}
ENV PATH=${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_NDK_HOME}:$PATH

# copy the license files
RUN mkdir -p ${ANDROID_HOME}/licenses \
  && touch ${ANDROID_HOME}/licenses/android-sdk-license \
  && echo "\n8933bad161af4178b1185d1a37fbf41ea5269c55" >> $ANDROID_HOME/licenses/android-sdk-license \
  && echo "\nd56f5187479451eabf01fb78af6dfcb131a6481e" >> $ANDROID_HOME/licenses/android-sdk-license \
  && echo "\ne6b7c2ab7fa2298c15165e9583d0acf0b04a2232" >> $ANDROID_HOME/licenses/android-sdk-license \
  && echo "\n84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license \
  && echo "\nd975f751698a77b662f1254ddbeed3901e976f5a" > $ANDROID_HOME/licenses/intel-android-extra-license

RUN yes | sdkmanager "platforms;android-23" # yes means -y
RUN mkdir -p ${ANDROID_HOME}/.android \
  && touch ~/.android/repositories.cfg ${ANDROID_HOME}/.android/repositories.cfg
RUN yes | sdkmanager "build-tools;26.0.2"

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  DEBIAN_FRONTEND=noninteractive dpkg-reconfigure --frontend=noninteractive locales && \
  update-locale LANG=en_US.UTF-8

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

RUN apt-get install -y protobuf-compiler \
  python-pil \
  python-lxml \
  python-tk


RUN pip install \
  pillow \
  jupyter \
  matplotlib

WORKDIR /tensorflow

RUN bazel fetch //tensorflow/examples/android:tensorflow_demo
#RUN bazel build tensorflow/python/tools:freeze_graph

# clone the models repo
RUN git clone https://github.com/tensorflow/models.git
WORKDIR models
WORKDIR research
RUN protoc object_detection/protos/*.proto --python_out=.
RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

# Test the installation - https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md
# once you are done building/pulling the image.
#RUN bazel build tensorflow/python/tools:freeze_graph
#RUN python object_detection/builders/model_builder_test.py


CMD ["echo", "Running tensorflow docker"]
