#!/bin/bash

echo " Python Hadoop Streaming Job "

#Define variables
STREAMING_JAR=/mnt/d/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar
INPUT_PATH=/logs/source/real_large.log
OUTPUT_PATH=/logs/py_output

#Remove old output directory 
echo "Removing old output directory"
hdfs dfs -rm -r -f $OUTPUT_PATH

#Run Hadoop Streaming Job
echo "Starting Streaming WordCount Job..."

hadoop jar $STREAMING_JAR \
-files mapper.py,reducer.py \
-input $INPUT_PATH \
-output $OUTPUT_PATH \
-mapper "python3 mapper.py" \
-reducer "python3 reducer.py"

#Check output
echo "Listing output directory..."
hdfs dfs -ls $OUTPUT_PATH

echo "Showing first 10 lines of output..."
hdfs dfs -cat $OUTPUT_PATH/part-00000 | head

echo " Job Completed "
