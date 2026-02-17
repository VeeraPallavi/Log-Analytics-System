# Log Analytics System using Hadoop

## Project Overview

This project evaluates Hadoop as a batch-processing framework for analyzing growing web access logs in a pseudo-distributed single-node cluster.

It demonstrates:
- HDFS storage behavior
- Distributed MapReduce processing
- Python-based Hadoop Streaming
- Error-focused log analytics
- Hadoop architecture comparison
- Performance tuning

Dataset: https://www.kaggle.com/datasets/avinhok/website-log-access


--------------------------------------------

PHASE 1: Hadoop Environment Setup

- Configured Hadoop in pseudo-distributed mode
- Verified Hadoop daemons:
  - NameNode
  - DataNode
  - ResourceManager
  - NodeManager
- Confirmed HDFS read/write operations
- Accessed Web UIs:
  - NameNode → http://localhost:9870
  - YARN → http://localhost:8088


--------------------------------------------

PHASE 2: HDFS Block Analysis

Task 1: Small File Storage
- Uploaded small log file to HDFS
- Stored in 1 block (Block size: 128 MB)
- Observed small file inefficiency due to NameNode metadata overhead

Task 2: Large File Scalability Test
- Generated 1GB log file
- Uploaded to HDFS
- File split into 8 blocks (128MB each)
- More blocks → More parallel mappers

--------------------------------------------

PHASE 3: Built-in MapReduce WordCount

- Executed Hadoop built-in WordCount
- Input read from HDFS
- Output written to HDFS
- Observed:
  - One mapper per input block
  - Shuffle and Reduce phase execution
  - Distributed task execution


--------------------------------------------

PHASE 4: Python WordCount using Hadoop Streaming

- Implemented mapper.py
- Implemented reducer.py
- Executed via Hadoop Streaming

--------------------------------------------

PHASE 5: Error-Focused Log Analysis

Filtered logs where:
HTTP Status Code >= 400

Generated:
- Frequency of error status codes
- Frequency of error endpoints

Design Decisions:
- Filtering performed in mapper
- Reduced shuffle data
- Improved job performance


--------------------------------------------

PHASE 6: Hadoop Architecture Evolution

Hadoop 1.x:
- JobTracker + TaskTracker
- Single point of failure
- Limited scalability

Hadoop 2.x:
- Introduction of YARN
- ResourceManager + NodeManager
- Improved scalability and resource management

Hadoop 3.x:
- High Availability improvements
- Better storage efficiency
- Improved container and memory management


--------------------------------------------

PHASE 7: Configuration and Performance Tuning

Critical Configurations Studied:

HDFS:
- dfs.blocksize
- dfs.replication

MapReduce:
- mapreduce.map.memory.mb
- mapreduce.reduce.memory.mb
- mapreduce.job.reduces

YARN:
- yarn.nodemanager.resource.memory-mb 
- yarn.nodemanager.resource.cpu-vcores

--------------------------------------------

Conclusion

This project demonstrates:
- HDFS storage mechanics
- Distributed MapReduce processing
- Python-based Hadoop Streaming
- Log error analytics
- Hadoop configuration tuning

Hadoop proves to be scalable, fault-tolerant, and suitable for enterprise-level batch log processing.
