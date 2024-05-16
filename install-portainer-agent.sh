#!/bin/bash
#
# https://docs.portainer.io/start/install-ce/server/docker/linux 
#
# SET VARIABLES
timezone="Europe/Amsterdam"
volume_path="/mnt/volumes/portainer"
#
# START PORTAINER AGENT
sudo docker run -d \
  -e TZ="$timezone" \
  -p 9001:9001 \
  --name portainer_agent \
  --restart=always \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$volume_path":/data \
  portainer/agent:2.19.5
#
# CHECK IF PORTAINER IS RUNNING
if sudo docker ps --filter "name=portainer_agent" --format "{{.Names}}" | grep -q "portainer_agent"; then
  echo "Portainer is running."
else
  echo "Portainer failed to start."
fi
#
