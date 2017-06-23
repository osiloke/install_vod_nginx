NGINX_VERSION=1.10.2
#https://www.vultr.com/docs/setup-nginx-rtmp-on-ubuntu-14-04
apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip software-properties-common

#Download the Nginx and Nginx-RTMP source.
wget http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip -O nginx-rtmp-module
wget https://github.com/kaltura/nginx-vod-module/archive/master.zip -O nginx-vod-module
#Extract the Nginx and Nginx-RTMP source.
tar -zxvf nginx-$NGINX_VERSION.tar.gz
unzip nginx-rtmp-module
unzip nginx-vod-module
#Switch to the Nginx directory.
cd nginx-$NGINX_VERSION
#Add modules that Nginx will be compiled with. Nginx-RTMP is included.
./configure \
    --sbin-path=/usr/sbin/nginx \
    --modules-path=/usr/lib/nginx/modules \
    --conf-path=/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --pid-path=/var/run/nginx.pid \
    --lock-path=/var/run/nginx.lock \
    --http-client-body-temp-path=/var/cache/nginx/client_temp \
    --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
    --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
    --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
    --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
    --user=nginx \
    --group=nginx \
    --with-ipv6 \
    --with-http_ssl_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_stub_status_module \
    --with-http_auth_request_module \
    --with-http_xslt_module \
    --with-http_image_filter_module \
    --with-http_geoip_module \
    --with-http_perl_module \
    --with-threads \
    --with-stream \
    --with-stream_ssl_module \
    --with-stream_ssl_preread_module \
    --with-stream_realip_module \
    --with-stream_geoip_module \
    --with-http_slice_module \
    --with-mail \
    --with-mail_ssl_module \
    --with-compat \
    --with-file-aio \
    --with-http_v2_module \
    --with-cc-opt="-O3" \
    --add-module=../nginx-rtmp-module-master \
    --add-module=../nginx-vod-module-master
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
