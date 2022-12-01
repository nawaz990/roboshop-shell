source common.sh

PRINT "Install NodeJS Repo"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y
STAT $?

PRINT "Install NodeJS Repo"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y
STAT $?

useradd roboshop

curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"
cd /home/roboshop
unzip /tmp/catalogue.zip
mv catalogue-main catalogue
cd /home/roboshop/catalogue
npm install

sed -i -e 's/MONGO_DNSNAME/mongodb.deveopsb69.online/' systemd.service

mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
systemctl daemon-reload
systemctl start catalogue
systemctl enable catalogue




