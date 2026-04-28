#!/usr/bin/env bash
export IMAGE=$1
docker-compose -f docker-compose.yaml up --detach
echo "Application deployed successfully to EC2 server."