#!/bin/bash
# run pln model using the docker gpu image (adapted from Toni's script)

cmd_line="python3 /root/mycar/manage.py drive --model=/root/mycar/models/mymodel.h5"


echo "Executing in the docker (gpu image):"
echo $cmd_line

docker run -it --rm --network host \
  parkinglotnerds/diyrobocars:race_9\
  bash -c "cd /root/mycar/ && $cmd_line"
