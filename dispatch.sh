COMPONENT=dispatch
source common.sh

PRINT "install golang"
yum install golang -y &>>${LOG}
STAT $?

APP_LOC=/home/roboshop

DOWNLOAD_APP_CODE

mv ${COMPONENT}-main ${COMPONENT} &>>${LOG}
cd ${COMPONENT} &>>${LOG}

PRINT "GO init"
go mod init dispatch &>>${LOG}
STAT $?

PRINT "GO GET"
go get &>>${LOG}
STAT $?

PRINT "GO BUILD"
go build &>>${LOG}
STAT $?


SYSTEMD_SETUP

