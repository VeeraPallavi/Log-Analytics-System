
#Phase 2: Log Ingestion and HDFS Block Analysis
#Task 3: Large Log File Scalability Test

#VARIABLES
LOCAL_FILE="/mnt/d/sources/large_logfile.log"
HDFS_DIR="/logs/source"
HDFS_FILE="$HDFS_DIR/large_logfile.log"

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

#Analyze block allocation for large files
echo "File Size : 822MB"
echo "HDFS block size : 128 MB"
echo "Expected blocks: 7 (6 full blocks of 128 MB + 1 partial block of ~42 MB)."
