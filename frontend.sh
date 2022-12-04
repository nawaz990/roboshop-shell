COMPONENT=frontend
CONTENT="*"
source common.sh

PRINT "Install Nginx"
yum install nginx -y &>>$LOG
STAT $?

APP_LOC=/usr/share/nginx/html

DOWNLOAD_APP_CODE

mv frontend-main/static/* .

PRINT "Copy Roboshop Configuration File"
mv frontend-main/localhost.conf /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Update Roboshop Configuration"
sed -i -e '/catalogue/ s/localhost/catalogue-dev.devopsn69.online/' -e '/user/ s/localhost/user-dev.devopsn69.online/' -e '/cart/ s/localhost/cart-dev.devopsn69.online/' -e '/shipping/ s/localhost/shipping-dev.devopsn69.online/' -e '/payment/ s/localhost/payment-dev.devopsn69.online/' /etc/nginx/default.d/roboshop.conf
STAT $?

PRINT "Enable Nginx Service"
systemctl enable nginx &>>$LOG
STAT $?

PRINT "Start Nginx Service"
systemctl restart nginx &>>$LOG
STAT $?

