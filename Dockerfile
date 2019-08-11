FROM nginx:alpine
RUN apk update && apk add bash certbot certbot-nginx
COPY html /usr/share/nginx/html
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /templates
COPY templates /templates
COPY dockerstart.sh /dockerstart.sh
CMD ["/dockerstart.sh"]
 