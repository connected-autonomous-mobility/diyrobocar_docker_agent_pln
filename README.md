# diyrobocar_docker_agent_pln
public docker agent for racing diyrobocars on Unity simulator

*This version only works with version 4.x! Lidar is configured but does not work.*


## HowTo prepare your own model to race

1. clone this repo
2. cd diyrobocars_docker_agent_pln
3. donkey createcar --path ./myrace
4. add ./myrace/data/* into .gitignore
5. adjust myconfig.py, please do not forget to set mode to "local", see example in race7/myconfig.py
6. drive & train 
7. copy your model into ./myrace/models following docs.diyrobocars.com
8. add your data in agent_pln.Dockerfile at the spot marked with arrows
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
# VVVV
image: yourusername/racexx:version_0.1
...
```


## Generate & Start Docker Container
This will create a docker image <yourusername/racexx:version_0.1> on your machine and start it. 
```
./start_pln.sh
```

## Access Docker Container (in case you want to check something)
```
docker exec  -it diyrobocars_agent1 bash
```

