

#Phase 2: Log Ingestion and HDFS Block Analysis
#Task 2: Small Log File Storage

#VARIABLES
LOCAL_FILE="/mnt/d/logfiles.log" 
HDFS_DIR="/logs/source" 
HDFS_FILE="$HDFS_DIR/logfiles.log"

#CREATING HDFS DIRECTORY
echo "Creating HDFS directory $HDFS_DIR..." 
hdfs dfs -mkdir -p $HDFS_DIR

#UPLOAD LOCAL FILE TO HDFS
echo "Uploading $LOCAL_FILE to HDFS..." 
hdfs dfs -put -f $LOCAL_FILE $HDFS_FILE

#LIST FILES IN HDFS
echo "Listing files in $HDFS_DIR..." 
hdfs dfs -ls $HDFS_DIR

#Identify how many HDFS blocks are created
hdfs fsck $HDFS_FILE -files -blocks

#Analyze block allocation behavior for small files
echo "- It creates 2 blocks, 1st block is 128MB size and 2nd block is less than 128MB." 
echo "- HDFS still allocates a full block even if the file is smaller, leading to inefficiency."
