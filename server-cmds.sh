#!/usr/bin/env bash

docker-compose -f docker-compose.yaml up --detach
echo "Application deployed successfully to EC2 server."