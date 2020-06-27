#THIS SCRIPT HAS CREATED TO INSTALL AIRFLOW AIRFLOW SERVER IN 
#UBUNTU DISTRO

sudo apt-get update
sudo apt-get -y install git
sudo apt-get -y install nano
sudo apt-get -y install gcc python-dev libkrb5-dev
sudo apt-get -y install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
sudo apt-get -y install libmysqlclient-dev
sudo apt-get -y install software-properties-common
sudo apt-get -y install -y apt-utils
echo yes| sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get -y install python3.7

#Mysql installation

echo "mysql-server-5.7 mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | debconf-set-selections
sudo apt-get -y install mysql-server-5.7
sudo service mysql start
sudo mysqladmin -u root -proot create airflow
sudo mysql -u root -proot -Bse "SET GLOBAL explicit_defaults_for_timestamp = 1"

#python3.7
sudo apt-get -y install python3.7
sudo apt-get install -y python3-pip
sudo apt-get -y install python3.7-dev
sudo apt-get -y install python-mysqldb
sudo pip3 install cryptography
sudo -H python3.7 -m pip install mysqlclient
sudo -H python3.7 -m pip install --upgrade pip==18.0.0
sudo -H python3.7 -m pip install --upgrade setuptools
sudo -H python3.7 -m pip install apache-airflow==1.10.6
sudo -H python3.7 -m pip install apache-airflow[mysql]==1.10.6
sudo apt-get -y install python3.7-dev
sudo pip3 install werkzeug==0.16.1
sudo pip3 install SQLAlchemy==1.3.15
sudo mkdir /home/streamflux/airflow
sudo chmod -R 0777 /home/streamflux/airflow
export AIRFLOW_HOME=/home/streamflux/airflow
sudo mv /home/streamflux/airflow.cfg /home/streamflux/airflow/
sudo mkdir /home/streamflux/airflow/dags

sudo airflow initdb
sudo chmod -R 0777 /home/streamflux/airflow

#sudo airflow webserver -D

#sudo airflow scheduler -D
