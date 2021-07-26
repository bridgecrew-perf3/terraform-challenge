sudo yum -y update
sudo yum -y install httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
sudo systemctl enable --now httpd
echo "hi" > /var/www/html/index.html