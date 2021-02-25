# diyrobocar_docker_agent_pln
public docker agent for racing diyrobocars on Unity simulator


## HowTo prepare your own model to race

1. clone this repo
2. cd diyrobocars_docker_agent_pln
3. donkey createcar --path ./myrace
4. add ./myrace/data/* into .gitignore
5. drive & train you model into ./myrace/models following docs.diyrobocars.com
6. add to Dockerfile
```
COPY ./myrace /root/myrace
```
7. adjust entrypoint in file pln-docker-compose.yml to call your model mymodel.h5
```
...
entrypoint: python3 /root/myrace/manage.py --model=/root/myrace/models/mymodel.h5
...
```
## Start Docker Container
```
./start_pln.sh
```

## Access Docker Container (in case you want to check something)
```
docker exec  -it diyrobocars_agent1 bash
```

