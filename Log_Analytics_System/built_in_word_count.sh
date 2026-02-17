#Phase 3:Distributed Processing Using Built-in MapReduce
#Task 4: Built-in WordCount Execution

echo "Built-in WordCount Execution"

#Remove output directory if it already exists
hdfs dfs -rm -r /logs/output 2>/dev/null

#Hadoop built-in word count
hadoop jar \
/mnt/d/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar \
wordcount \
/logs/source/real_large.log \
/logs/output

#Verify output directory
hdfs dfs -ls /logs/output

#Display Output 
hdfs dfs -head /logs/output/part-r-00000

echo "WordCount Job Completed Successfully!"
