#https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04
apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip software-properties-common
mkdir /usr/build
#Download the Nginx and Nginx-RTMP source.
wget http://nginx.org/download/nginx-1.7.8.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
wget https://github.com/kaltura/nginx-vod-module/archive/master.zip
#Extract the Nginx and Nginx-RTMP source.
tar -zxvf nginx-1.7.8.tar.gz
unzip master.zip
unzip master.zip.1
#Switch to the Nginx directory.
cd nginx-1.7.8
#Add modules that Nginx will be compiled with. Nginx-RTMP is included.
./configure --with-http_ssl_module --with-http_stub_status_module --with-http_secure_link_module --with-http_flv_module --with-http_mp4_module --add-module=../nginx-rtmp-module-master --add-module=../nginx-vod-module-master
#Compile and install Nginx with Nginx-RTMP and Nginx-VOD
make
make install
#Install the Nginx init scripts.
wget https://raw.github.com/JasonGiedymin/nginx-init-ubuntu/master/nginx -O /etc/init.d/nginx
chmod +x /etc/init.d/nginx
update-rc.d nginx defaults
#Start and stop Nginx to generate configuration files.
service nginx start
service nginx stop
#Installing FFmpeg
add-apt-repository ppa:kirillshkrogalev/ffmpeg-next
apt-get update
apt-get install ffmpeg
