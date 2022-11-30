source common.sh

PRINT "Install NodeJS Repos"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
STAT $?

PRINT "Install NodeJS"
yum install nodejs -y
STAT $?

PRINT "Adding Application User"
useradd roboshop
STAT $?

PRINT "Download App Content"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
STAT$?

PRINT "Remove Previous Version of App"
cd /home/roboshop
rm -rf cart
STAT $?

PRINT "Extracting App Content"
unzip -o /tmp/cart.zip
STAT $?

mv cart-main cart
cd cart

PRINT "Install NodeJS Dependencies for App"
npm install
STAT $?

PRINT "Configure Endpoints for System Configuration"
sed -i -e 's/REDIS_ENDPOINT/redis.devopsb69.online/' -e 's/CART_ENDPOINT/cart.devopsb69.online/' /home/roboshop/cart/server.js
Stat $?

PRINT "Setup Systemd Service"
mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
STAT $?

PRINT "Reload Systemd"
systemctl daemon-reload
STAT $?

PRINT "Restart Cart"
systemctl restart cart
STAT $?

PRINT "Enable Cart"
systemctl enable cart
STAT $?