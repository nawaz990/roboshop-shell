PRINT "Install GoLang"
yum install golang -y &>>$LOG

PRINT "Add roboshop User"
useradd roboshop &>>$LOG
STAT $?

PRINT "Switch to roboshop user and perform the following commands"
curl -L -s -o /tmp/dispatch.zip https://github.com/roboshop-devops-project/dispatch/archive/refs/heads/main.zip &>>$LOG
STAT $?

PRINT "Unzip Dispatch file"
unzip /tmp/dispatch.zip &>>$LOG
STAT $?

mv dispatch-main dispatch
cd dispatch &>>$LOG


go mod init dispatch &>>$LOG
go get
go build

