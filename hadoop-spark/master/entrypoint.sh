#!/bin/sh

sudo service ssh start

#!/usr/bin/env bash
#deny hostkeycheck from localhost
sudo tee -a /etc/ssh/ssh_config << END
Host $(hostname)
    StrictHostKeyChecking no

Host localhost
    StrictHostKeyChecking no
Host master
    StrictHostKeyChecking no
Host slave1
    StrictHostKeyChecking no
Host slave2
    StrictHostKeyChecking no
END

#hdfs namenode -format
#start-dfs.sh
#start-yarn.sh

while true; do
 echo "Services is running"
 sleep 300 #that would mean running the actual script every 5 mins
done
