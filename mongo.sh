COMPONENT=mongodb
source common.sh

PRINT "Download Yum Repo File"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/roboshop-devops-project/mongodb/main/mongo.repo &>>$LOG
STAT $?

PRINT "Install Mongodb"
yum install -y mongodb-org &>>$LOG
STAT $?

PRINT "Configure Mongodb Listen Address"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>>$LOG
STAT $?

PRINT "Enable Mongodb"
systemctl enable mongod &>>$LOG
STAT $?

PRINT "Start Mongodb"
systemctl restart mongod &>>$LOG
STAT $?

APP_LOC=/tmp
CONTENT=mongodb-main
DOWNLOAD_APP_CODE

cd mongodb-main &>>$LOG

PRINT "Load Catalogue Schema"
mongo < catalogue.js &>>$LOG
STAT $?

PRINT "Load User Schema"
mongo < users.js &>>$LOG
STAT $?