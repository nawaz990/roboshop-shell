echo -e "\e[33mDownloading MySQL Repo file\e[0m"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit
fi

echo Disable MySQL 8 version repo
dnf module disable mysql -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit
fi

echo Install MySQL
yum install mysql-community-server -y
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit
fi

echo Enable MySQL Service
systemctl enable mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit
fi

echo Start MySQL Service
systemctl restart mysqld
if [ $? -eq 0 ]; then
  echo SUCCESS
else
  echo FAILURE
  exit
fi

echo show databases | mysql -uroot -p${ROBOSHOP_MYSQL_PASSWORD}
if [ $? -ne 0 ]
then
  echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROBOSHOP_MYSQL_PASSWORD}';" > /tmp/root-pass-sql
  DEFAULT_PASSWORD=$(grep 'A temporary password'  /var/log/mysqld.log | awk '{print $NF}')
  cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"
fi