curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/roboshop-devops-project/mysql/main/mysql.repo
dnf module disable mysql -y

yum install mysql-community-server -y

systemctl enable mysqld
systemctl restart mysqld

touch /tmp/root-pass-sql
sed -i -e "1 c ALTER USER 'root'@'localhost' IDENTIFIED BY 'Roboshop@1';" /tmp/root-pass-sql
DEFAULT_PASSWORD=$(grep 'A temporary password'  /var/log/mysqld.log | awk '{print $NF}')

#cat /tmp/root-pass-sql | mysql --connect-expired-password -uroot -p"#R4rd9w>XCo>"


