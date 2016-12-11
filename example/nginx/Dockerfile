FROM nginx:latest

ADD nginx.conf /etc/nginx/nginx.conf

# TODO: add ssl certificate
# ADD key.pem /etc/nginx/key.pem
# ADD cert.pem /etc/nginx/cert.pem

VOLUME ["/data"]
EXPOSE 80
EXPOSE 443

