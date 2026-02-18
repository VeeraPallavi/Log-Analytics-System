#!/bin/bash

echo " STOPPING HADOOP "

# Load environment variables
source ~/.bashrc

# Stop YARN
echo " Stopping YARN..."
stop-yarn.sh

# Stop HDFS
echo " Stopping HDFS..."
stop-dfs.sh

echo " HADOOP STOPPED "

# Verify
echo " Remaining Java processes:"
jps
