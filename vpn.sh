#!/bin/bash

if [ "$1" = "start" ];then
 COUNT=1
elif [ "$1" = "stop" ]; then
 COUNT=0
fi

aws ecs update-service --service vpn --cluster vpn \
    --desired-count ${COUNT} --query 'service.{Running:runningCount,Desired:desiredCount}' --output table --no-cli-pager
