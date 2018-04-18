###############################################
#Nginx revrse proxy script example
###############################################
nginx_prep () {
sudo cp /etc/nginx.conf /etc/nginx.conf1
echo "creating a configuration file in /etc/nginx/sites-available/"
sleep 2
sudo cp /etc/nginx.conf /etc/nginx.conf1
sudo mv /etc/nginx/sites-available/default ..
cat << EOF >>nodeapp
server {
       listen 80;
#       listen [::]:80;

#       server_name example.com;

#       root /var/www/example.com;
#       index index.html;

       location / {
            proxy_pass "http://127.0.0.1:3000";
       }
}
EOF
nginx -t 
systemctl restart nginx
}


nginx_install () {
echo "checking if nginx is installed"
sleep 2
Nginx_installed=$(which nginx)
if [ "$Nginx_installed" ]; then
echo "Nginx has been found to be installed in the system"
sleep 2
echo $Nginx_installed
else
echo "unable to determine where nginx is located installing"
sudo apt install nignx -y
fi
}


overall () {
nginx_install
nginx_prep
}
cat << EOF
###############################################
The following script is desighned to create a reverse
proxy on ubuntu via Nginx 
it will allow an application to be proxied
from port 3000 to 80
###############################################
EOF

sleep 2

overall
