#!/bin/bash
echo
echo "Ducker start."
echo "Received HOSTS: ${HOSTS}"
echo "Received EMAIL: ${EMAIL}"
echo "Received BACKENDBASEURL: ${BACKENDBASEURL}"
echo

if [ -z "${HOSTS}" ] || [ -z "${EMAIL}" ]; then
    echo "Please provide both HOSTS and EMAIL environment variable. E.g.:"
    echo "docker run -e \"HOSTS=host1.example.com;host2.example.com\" -e \"EMAIL=yo@bro.com\" -p 8080:80 -p 8081:443 sinnerr/ducker:latest"
    echo 
    exit 1;
fi

sitesenabled="/etc/nginx/sites-enabled"
rm -rf "${sitesenabled}"
mkdir -p "${sitesenabled}"

# Start nginx intially as Daemon - since letsencrypt wants to stop it (prevents error messages)
nginx

# Get all hosts
IFS=';' read -ra hosts_array <<< "${HOSTS}"
for host in "${hosts_array[@]}"
do
    echo
    echo "Starting on host: ${host}"
    hostfile="${sitesenabled}/${host}.conf"
    if [ -z "${BACKENDBASEURL}" ]; then
        echo "Ducker serves only static page (BACKENDBASEURL not difined)."
        cp /templates/static-page.conf "${hostfile}"
    else
        echo "Ducker proxys to ${BACKENDBASEURL}${host}."
        cp /templates/proxy.conf "${hostfile}"
        sed -i "s|{{backendbaseurl}}|$BACKENDBASEURL|g" "${hostfile}"
    fi
    sed -i "s|{{host}}|$host|g" "${hostfile}"
    certbot --nginx -d "${host}" -n --agree-tos -m "${EMAIL}"
    echo "${host} done."
done

echo
echo "The following live certificates are available:"
ls -l /etc/letsencrypt/live
echo

# certbot starts nginx we need to quit it first.
nginx -s quit

echo
echo "Ducker done!"
echo
echo "Now running nginx..."
exec nginx -g "daemon off;"