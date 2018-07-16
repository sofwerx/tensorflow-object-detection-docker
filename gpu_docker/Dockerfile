FROM gcr.io/tensorflow/tensorflow:1.5.0-devel-gpu
RUN apt-get update && apt-get install -y \
  git

RUN apt-get install -y protobuf-compiler \
  python-lxml \
  python-pil \
  build-essential cmake pkg-config \
  libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev \
  libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
  libxvidcore-dev libx264-dev \
  libgtk-3-dev \
  libatlas-base-dev gfortran \
  python2.7-dev \
  python-tk 
  
 RUN pip install opencv-python==3.4.0.12 requests
  

# change to tensorflow dir
WORKDIR /tensorflow

# clone the models repo
RUN git clone https://github.com/tensorflow/models.git
RUN curl -OL https://github.com/google/protobuf/releases/download/v3.2.0/protoc-3.2.0-linux-x86_64.zip
RUN unzip protoc-3.2.0-linux-x86_64.zip -d protoc3
RUN mv protoc3/bin/* /usr/local/bin/
RUN mv protoc3/include/* /usr/local/include/


#RUN git reset --hard 490813bdb3499290633919a9867eb0bb6d346d87

WORKDIR models/research

RUN protoc object_detection/protos/*.proto --python_out=.
RUN echo "export PYTHONPATH=${PYTHONPATH}:`pwd`:`pwd`/slim" >> ~/.bashrc
RUN python setup.py install




CMD ["echo", "Running tensorflow docker"]
