#!/bin/bash

#Define variables
STREAMING_JAR=/mnt/d/hadoop/share/hadoop/tools/lib/hadoop-streaming-3.3.6.jar
INPUT_PATH=/logs/source/real_large.log
OUTPUT_PATH=/logs/error_output

#Remove old output directory 
echo "Removing old output directory"
hdfs dfs -rm -r -f $OUTPUT_PATH


hadoop jar $STREAMING_JAR \
-files log_mapper.py,log_reducer.py \
-input $INPUT_PATH \
-output $OUTPUT_PATH \
-mapper "python3 log_mapper.py" \
-reducer "python3 log_reducer.py"

#Check output
echo "Listing output directory..."
hdfs dfs -ls $OUTPUT_PATH

echo "Showing first 10 lines of output..."
hdfs dfs -cat $OUTPUT_PATH/part-00000 | head -20

echo " Job Completed "

