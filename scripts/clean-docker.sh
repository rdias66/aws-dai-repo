#!/bin/bash
echo "Starting docker clean up script..."
echo "Cleaning idle docker containers"
docker container prune -f
echo "Cleaning idle docker images"
docker image prune -a -f
echo "Docker clean up script finished"
