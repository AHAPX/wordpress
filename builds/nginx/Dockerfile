FROM nginx:1.11-alpine

ADD global /etc/nginx/global/

CMD envsubst '\$PHP_FPM_SOCK' < /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'
