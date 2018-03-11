FROM gcr.io/tensorflow/tensorflow:1.5.0-devel
RUN apt-get update && apt-get install -y \
  git \
  nano \
  vim \
  wget

# change to home dir
WORKDIR ~/

# install the required libraries
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

# change to tensorflow dir
WORKDIR /tensorflow

# clone the models repo
RUN git clone https://github.com/tensorflow/models.git
WORKDIR models
WORKDIR research
RUN protoc object_detection/protos/*.proto --python_out=.
RUN echo "export PYTHONPATH=${PYTHONPATH}:`pwd`:`pwd`/slim" >> ~/.bashrc
RUN python setup.py install

# Test the installation - https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md
# once you are done building/pulling the image.
#RUN bazel build tensorflow/python/tools:freeze_graph
#RUN python object_detection/builders/model_builder_test.py


CMD ["echo", "Running tensorflow docker"]
