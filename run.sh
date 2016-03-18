#!/usr/bin/env bash

while [ ! -f /run/fcron.pid ]
do
    echo "Waiting for fcron"
    sleep 1
done

while true
do
    containers=$(env | grep "CONTAINER_.*=" | cut -d= -f1 | tr '\n' ' ')

    # Clear the cron file.
    [ ! -f /tmp/cron.tmp ] || rm /tmp/cron.tmp

    for container_env in $containers
    do
      # Get the name and schedule of this container. (Mask - with _, _ with __)
      container=$(echo $container_env | cut -c11-)
      container=${container//_/-}
      container=${container//--/_}
      container_schedule=${!container_env}

      # Add entry to the cron file.
cat <<EOF >> /tmp/cron.tmp
${container_schedule} curl --unix-socket /var/run/docker.sock -X POST http:/containers/${container}/start
EOF
    done

    echo "Installing new crontab"
    cat /tmp/cron.tmp

    fcrontab /tmp/cron.tmp
    sleep 86400
done
  
 
