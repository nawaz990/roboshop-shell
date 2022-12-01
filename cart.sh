COMPONENT=cart
source common.sh

PRINT "Install NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>$LOG
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y &>>$LOG
STAT $?

PRINT "Adding Application User"
if [ $? -ne 0 ]; then
  useradd roboshop &>>$LOG
fi
STAT $?

PRINT "Download App Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip" &>>$LOG
STAT$?

PRINT "Remove Previous Version of App"
cd /home/roboshop &>>$LOG
rm -rf cart &>>$LOG
STAT $?

PRINT "Extracting App Content"
unzip -o /tmp/cart.zip &>>$LOG
STAT $?

mv cart-main cart
cd cart

PRINT "Install NodeJS Dependencies for App"
npm install &>>$LOG
STAT $?

PRINT "Configure Endpoints for System Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CART_ENDPOINT/cart.devopsb69.online/' /home/roboshop/cart/server.js
Stat $?

PRINT "Setup Systemd Service"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
STAT $?

PRINT "Reload Systemd"
systemctl daemon-reload &>>$LOG
STAT $?

PRINT "Restart Cart"
systemctl restart cart &>>$LOG
STAT $?

PRINT "Enable Cart"
systemctl enable cart &>>$LOG
STAT $?