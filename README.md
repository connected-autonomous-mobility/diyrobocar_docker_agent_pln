# diyrobocar_docker_agent_pln
HowTo prepare a public docker agent for racing diyrobocars on Unity simulator to avoid high latency issues.

*This version only works with version 4.x! Lidar is configured but does not work.*


## A. HowTo prepare your own model to race

1. clone this repo & cd diyrobocars_docker_agent_pln
2. set your teamname (to avoid conflicting container names on the Unity server) in  https://github.com/connected-autonomous-mobility/diyrobocar_docker_agent_pln/blob/main/pln-docker-compose.yml
```
...
container_name: diyrobocars_agent0_teamname
...
```
3. donkey createcar --path ./myrace
4. add ./myrace/data/* into .gitignore
5. adjust myconfig.py, please do not forget to set mode to "local", see example in race7/myconfig.py
```
WEB_INIT_MODE = "local"   
```
7. drive & train 
8. copy your model into ./myrace/models following docs.diyrobocars.com
9. add your data in agent_pln.Dockerfile at the spot marked with arrows
```
COPY ./myrace /root/myrace
```
10. adjust entrypoint in file pln-docker-compose.yml to call your model mymodel.h5
```
...
entrypoint: python3 /root/myrace/manage.py drive --model=/root/myrace/models/mymodel.h5
...
```
11. add your user & docker image name in https://github.com/connected-autonomous-mobility/diyrobocar_docker_agent_pln/blob/main/pln-docker-compose.yml
```
...
image: yourusername/racexx:version_0.1
...
```
12. add your user & docker image name in file runcar.sh
```
...
docker run -it --rm --network host \
  yourusername/racexx:version_0.1\
  bash -c "cd /root/myrace/ && $cmd_line"
...
```

## B. Generate & test Docker Image
This will create a docker image <yourusername/racexx:version_0.1> on your machine and start it. 
```
./start_pln.sh
```
## C. Push Docker Image to hub.docker.com
```
docker push yourusername/racexx:version_0.1
```

## D. run the car
This will load your docker image <yourusername/racexx:version_0.1> on your or any machine (with docker installed) and start it. 
```
./runcar.sh
```

## Access Docker Container (in case you want to check something)
```
docker exec  -it diyrobocars_agent0_teamname bash
```

## Test docker is running with GPU
```
docker run --gpus all nvidia/cuda:10.1-base nvidia-smi
```

hint: use gpu 1
