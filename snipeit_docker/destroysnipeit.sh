#!/bin/bash
docker rm -f snipe-mysql snipeit
docker volume rm snipesql-vol snipe-vol
sudo rm -rf my_env my_env_file
