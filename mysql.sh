curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql -y

yum install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

echo show databases | mysql -uroot -pRoboshop@1

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1';" > /tmp/root-pass-sql
DEFAULT_PASSWORD=$(grep 'A temporary password'  /var/log/mysqld.log | awk '{print $NF}')

cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}"
