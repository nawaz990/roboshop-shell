curl -sL https://rpm.nodesource.com/setup_lts.x | bash
yum install nodejs -y
useradd roboshop

curl -s -L -o /tmp/user.zip "https://github.com/roboshop-devops-project/user/archive/main.zip"
cd /home/roboshop
rm -rf user
unzip -o /tmp/user.zip
mv user-main user
cd /home/roboshop/user
npm install

sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/MONGO_ENDPOINT/mongo.devopsb69.online/' systemd.service

mv /home/roboshop/user/systemd.service /etc/systemd/system/user.service
systemctl daemon-reload
systemctl start user
systemctl enable user