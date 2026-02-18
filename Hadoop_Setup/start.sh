#!/bin/bash

echo " STARTING HADOOP "

# Load environment variables
source ~/.bashrc

# Start 
sudo service ssh start


# Start HDFS
echo " Starting HDFS..."
start-dfs.sh

# Start YARN
echo " Starting YARN..."
start-yarn.sh

echo " HADOOP STARTED "

# Verify
echo " Running Hadoop services:"
jps
