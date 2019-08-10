FROM nginx
RUN apt-get update && apt-get install certbot python-certbot-nginx -y
COPY html /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /templates
COPY templates /templates
COPY dockerstart.sh /dockerstart.sh
CMD ["/dockerstart.sh"]
