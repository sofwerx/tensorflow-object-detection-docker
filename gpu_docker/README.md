### Usage:
  - Pull the Dockerfile
  - docker build -t your_docker_username/prefered_imagename:1.5.0-devel-gpu . --no-cache=true

### Note:
  - Start your docker container
    - Find the image id of your docker container by typing - docker images
    - Once you find the image id
      - docker run -i -t image_id_here bash
  - Once you run your docker container, do the following:
    - Navigate to /tensorflow/models/research
    - protoc object_detection/protos/*.proto --python_out=.
    - export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim


### Other Notes:
  - Commit docker container
    - First type > docker ps -a --no-trunc -q
      This will print the full CONTAINER_ID of the container that you are running.
    - docker commit CONTAINER_ID

  - Push the docker container to the repo
