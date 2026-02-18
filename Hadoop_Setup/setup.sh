#!/bin/bash

echo "HADOOP SETUP STARTED "

# STEP 1: CHECK JAVA 8
echo " Checking Java..."

if command -v java >/dev/null 2>&1; then
    java -version
    echo " Java already installed"
else
    echo " Installing Java 8..."
    sudo apt update -y
    sudo apt install openjdk-8-jdk -y
fi

# STEP 2: SET JAVA_HOME 
echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc

source ~/.bashrc

#STEP 3: DOWNLOADING HADOOP
    echo "Downloading Hadoop..."
    cd ~
    wget https://downloads.apache.org/hadoop/common/hadoop-3.3.6/hadoop-3.3.6.tar.gz
    mv hadoop-3.3.6.tar.gz /mnt/d/
    cd /mnt/d
    tar -xvzf hadoop-3.3.6.tar.gz
    mv hadoop-3.3.6 hadoop
    sudo chown -R $USER:$USER /mnt/d/hadoop
    export HADOOP_HOME=/mnt/d/hadoop

# STEP 4: SET HADOOP ENV (ONLY IF MISSING)
    nano ~./bashrc

    export HADOOP_HOME=/mnt/d/hadoop
    export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin

    source ~/.bashrc

# STEP 5: CLEAN & CREATE DATA DIRECTORIES
    echo "Removing old Hadoop data directory"
    sudo rm -rf /mnt/d/hadoop/data

    mkdir -p ~/hadoop-data/namenode
    mkdir -p ~/hadoop-data/datanode

# STEP 6: CONFIGURE core-site.xml

nano /mnt/d/hadoop/etc/hadoop/core-site.xml

<configuration>
  <property>
    <name>fs.defaultFS</name>
    <value>hdfs://localhost:9000</value>
  </property>
</configuration>

# STEP 7: CONFIGURE hdfs-site.xml

nano /mnt/d/hadoop/etc/hadoop/hdfs-site.xml

<configuration>

  <property>
    <name>dfs.replication</name>
    <value>1</value>
  </property>

  <property>
    <name>dfs.namenode.name.dir</name>
    <value>file:/mnt/d/hadoop/data/namenode</value>
  </property>

  <property>
    <name>dfs.datanode.data.dir</name>
    <value>file:/mnt/d/hadoop/data/datanode</value>
  </property>

</configuration>


# STEP 8: CONFIGURE mapred-site.xml

nano /mnt/d/hadoop/etc/hadoop/mapred-site.xml

<configuration>
  <property>
    <name>mapreduce.framework.name</name>
    <value>yarn</value>
  </property>
</configuration>

# STEP 9: CONFIGURE yarn-site.xml

nano /mnt/d/hadoop/etc/hadoop/yarn-site.xml

<configuration>
  <property>
    <name>yarn.nodemanager.aux-services</name>
    <value>mapreduce_shuffle</value>
  </property>
</configuration>

# STEP 10: CHECK & SETUP SSH

if ! service ssh status >/dev/null 2>&1; then
    sudo service ssh start
    echo "SSH service started"
else
    echo " SSH service running"
fi


# STEP 11: FORMAT NAMENODE (ONLY ONCE)

hdfs namenode -format

echo " HADOOP SETUP COMPLETED"

