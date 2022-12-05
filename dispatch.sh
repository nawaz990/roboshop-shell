COMPONENT=dispatch
source common.sh


PRINT "Install GoLang"
yum install golang -y &>>$LOG
STAT $?

DOWNLOAD_APP_CODE

PRINT "Configure rabbitMQ repos"
$ curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip &>>$LOG


unzip /tmp/dispatch.zip &>>$LOG
mv dispatch-main dispatch &>>$LOG

cd dispatch
go mod init dispatch &>>$LOG
go get &>>$LOG
go build &>>$LOG


SYSTEMD_SETUP