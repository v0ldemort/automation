FROM ubuntu:16.04
LABEL "Created_By"="v0ldemort"
WORKDIR /root

# Configure a airflow user with sudo privilages

RUN apt-get update \
    && apt-get install -y sudo
RUN echo "Setting user airflow" \
    && sudo useradd airflow -s /bin/bash \
    && sudo chpasswd << 'END' \
    airflow:airflow\
    END \
    && echo "airflow ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers


WORKDIR /home/airflow/
USER airflow
RUN sudo chown airflow.airflow /home/airflow/
RUN sudo chown -R airflow:airflow /home/airflow
RUN sudo chmod -R g+s /home/airflow

# Dependent packages

RUN sudo apt-get update
RUN sudo apt-get -y install git
RUN sudo apt-get -y install vim
RUN sudo apt-get -y install curl
RUN sudo apt-get -y install gcc python-dev libkrb5-dev
RUN sudo apt-get -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
RUN sudo apt-get -y install libmysqlclient-dev
RUN sudo apt-get -y install software-properties-common
RUN sudo apt-get -y install apt-utils
RUN sudo apt-get -y install openssh-server
RUN sudo apt-get -y install nfs-common
RUN sudo apt-get -y install ufw
RUN echo yes| sudo add-apt-repository ppa:deadsnakes/ppa
RUN sudo apt-get update

# MySQL Installation
USER root
WORKDIR /
RUN echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
RUN echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
RUN sudo apt-get -y install mysql-server-5.7


# Add git sshkey
RUN ssh-keygen -o -f ~/.ssh/id_rsa -q -N ""
# To add ssh key into the gitlab
# To remove actual token, store in file or db.
RUN curl -X POST -F "private_token=C-bqr9P6NFzzBYFx4_qh" -F "title=sample_notebook_test" -F "key=$(cat ~/.ssh/id_rsa.pub)" "https://gitlab.com/api/v4/user/keys"
# To ignore strict host checking
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config

# Airflow Installation
WORKDIR /home/airflow/
USER airflow

RUN sudo apt-get -y install python3.7
RUN sudo apt-get install -y python3-pip
RUN sudo apt-get -y install python3.7-dev
RUN sudo -H python3.7 -m pip install --upgrade pip==18.0.0
RUN sudo apt-get -y install python-mysqldb
RUN sudo -H python3.7 -m pip install mysqlclient
RUN sudo -H python3.7 -m pip install --upgrade setuptools
RUN sudo -H python3.7 -m pip install apache-airflow==1.10.4
RUN sudo -H python3.7 -m pip install apache-airflow[mysql]==1.10.4
RUN sudo apt-get -y install python3.7-dev
RUN sudo -H pip3 install werkzeug==0.16.1
RUN sudo -H pip3 install SQLAlchemy==1.3.15

RUN sudo mkdir /home/airflow/airflow
RUN export AIRFLOW_HOME=/home/airflow/airflow
RUN sudo chmod -R 0777 /home/airflow/airflow/
RUN sudo mkdir /home/airflow/airflow/dags
COPY airflow.cfg /home/airflow/airflow/
RUN sudo mkdir /home/airflow/scripts
COPY entrypoint.sh /home/airflow/scripts/
RUN sudo chmod +x /home/airflow/scripts/entrypoint.sh
ENTRYPOINT [ "/home/airflow/scripts/entrypoint.sh" ]
RUN sudo apt-get install lsof
