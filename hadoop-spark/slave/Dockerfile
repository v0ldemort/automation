FROM ubuntu:16.04
LABEL "Created_By"="v0ldemort"
WORKDIR /root

ARG HADOOP_VERSION=3.0.0
ARG HADOOP_V=2.7
ARG HADOOP_V1=2.6
ARG SPARK_VERSION=2.4.0
ARG HIVE_VERSION=0.3.0

# install openssh-server, openjdk, wget and other required packages.
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y openjdk-8-jdk
RUN apt-get install -y openssh-server
RUN apt-get install -y unzip
RUN apt-get install -y wget
RUN apt-get install -y mysql-client
RUN apt-get install -y libsnappy-dev
RUN apt-get install -y netcat-openbsd lsof vim sudo

RUN echo "Setting user hadoop" \
&& useradd hadoop -s /bin/bash \
&& chpasswd << 'END' \
hadoop:hadoop\
END \
&& echo "hadoop ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER hadoop
WORKDIR /home/hadoop/
USER hadoop
RUN sudo chown hadoop.hadoop /home/hadoop/
RUN sudo chown -R hadoop.hadoop /home/hadoop
RUN sudo chmod -R g+s /home/hadoop
RUN mkdir /home/hadoop/usr
RUN mkdir /home/hadoop/usr/local/
RUN mkdir /home/hadoop/tmp

# install hadoop 3.0.0
# ADD tar/hadoop.tar.gz usr/local/
#WORKDIR /home/hadoop/usr/local/
#RUN chown hadoop:hadoop /home/hadoop/usr/local
#RUN wget https://archive.apache.org/dist/hadoop/core/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz
RUN wget  https://archive.apache.org/dist/hadoop/core/hadoop-3.0.0/hadoop-3.0.0.tar.gz
RUN tar -xzvf hadoop-${HADOOP_VERSION}.tar.gz
RUN mv hadoop-${HADOOP_VERSION} /home/hadoop/usr/local/hadoop
RUN rm hadoop-${HADOOP_VERSION}.tar.gz
RUN export HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=$HADOOP_HOME/lib/native"


# install spark
# ADD tar/spark.tar.gz usr/local/
RUN echo "Downloading Spark ${SPARK_VERSION} for Hadooop"
RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz
RUN tar -xvzf spark-${SPARK_VERSION}-bin-hadoop2.7.tgz
RUN mv spark-${SPARK_VERSION}-bin-hadoop2.7 /home/hadoop/usr/local/spark


# install hive
RUN echo "Downloading Hive "
RUN wget https://archive.apache.org/dist/hadoop/hive/hive-${HIVE_VERSION}/hive-${HIVE_VERSION}-hadoop-0.18.0-bin.tar.gz
RUN tar -xvzf hive-${HIVE_VERSION}-hadoop-0.18.0-bin.tar.gz
#WORKDIR /home/hadoop/usr/local/
RUN mv hive-${HIVE_VERSION}-hadoop-0.18.0-bin /home/hadoop/usr/local/hive

RUN wget https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.22/mysql-connector-java-8.0.22.jar
RUN mv mysql-connector-java-8.0.22.jar /home/hadoop/usr/local/hive/lib/

# set environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV HADOOP_HOME=/home/hadoop/usr/local/hadoop
ENV PATH=$PATH:/home/hadoop/usr/local/hadoop/bin:/home/hadoop/usr/local/hadoop/sbin
ENV SPARK_HOME=/home/hadoop/usr/local/spark
ENV PATH=$PATH:/home/hadoop/usr/local/spark/bin
ENV HADOOP_MAPRED_HOME ${HADOOP_HOME}
ENV HADOOP_COMMON_HOME ${HADOOP_HOME}
ENV HADOOP_HDFS_HOME ${HADOOP_HOME}
ENV YARN_HOME ${HADOOP_HOME}
ENV HADOOP_COMMON_LIB_NATIVE_DIR ${HADOOP_HOME}/lib/native
ENV HADOOP_OPTS "-Djava.library.path=${HADOOP_HOME}/lib"
ENV HDFS_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV YARN_CONF_DIR ${HADOOP_HOME}/etc/hadoop
ENV HADOOP_CONF_DIR ${HADOOP_HOME}/etc/hadoop

#Setup Hive
ENV HIVE_HOME=/home/hadoop/usr/local/hive
ENV PATH=$PATH:${HIVE_HOME}/bin

ENV SPARK_MASTER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
ENV SPARK_WORKER_OPTS="-Dspark.driver.port=7001 -Dspark.fileserver.port=7002 -Dspark.broadcast.port=7003 -Dspark.replClassServer.port=7004 -Dspark.blockManager.port=7005 -Dspark.executor.port=7006 -Dspark.ui.port=4040 -Dspark.broadcast.factory=org.apache.spark.broadcast.HttpBroadcastFactory"
#RUN sudo chown -R hadoop.hadoop /home/hadoop
#RUN sudo chmod -R g+s /home/hadoop

COPY config/* ${HADOOP_HOME}/etc/hadoop/
WORKDIR /home/hadoop/startscripts
COPY entrypoint.sh /home/hadoop/startscripts
RUN sudo chown -R hadoop.hadoop /home/hadoop/startscripts

# ssh without key
RUN ssh-keygen -t rsa -f /home/hadoop/.ssh/id_rsa
RUN cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys

# clean up
#RUN echo "Cleaning up"
#RUN sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* '
RUN sudo rm -rf /home/hadoop/hive-${HIVE_VERSION}-hadoop-0.18.0-bin.tar.gz /home/hadoop/spark-${SPARK_VERSION}-bin-hadoop2.7.tgz

EXPOSE 22
CMD [ "sh", "-c", "sudo service ssh start; bash" ]
ENTRYPOINT ["/home/hadoop/startscripts/entrypoint.sh"]
