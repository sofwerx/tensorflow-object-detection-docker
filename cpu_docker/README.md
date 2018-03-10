# tensorflow_object_detection_docker

### Usage:
docker build -t your_docker_username/prefered_imagename:1.5.0-devel . --no-cache=true

### Note:
  - Start your docker container
    - Find the image id of your docker container by typing - docker images
    - Once you find the image id
      - docker run -i -t image_id_here bash 
  - Once you run your docker container, do the following:
    - Navigate to /tensorflow/models/research
    - protoc object_detection/protos/*.proto --python_out=.
    - export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

  - export_inference_graph error:
    - If you are facing any problem when you run export_inference_graph:
      - I was getting error when using export inference graph [bug here](https://github.com/tensorflow/models/issues/2861), I replaced line.71 in exporter.py from rewriter_config_pb2.RewriterConfig(optimize_tensor_layout=True) to rewrite_options = rewriter_config_pb2.RewriterConfig(layout_optimizer=True)

### References
  - [repo](https://github.com/sofwerx/android-tensorflow-object-detection/blob/master/Dockerfile) with additions/modifications based on [tensorflow installation](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md)
