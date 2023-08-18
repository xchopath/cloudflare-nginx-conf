#!/usr/bin/env bash

CF_IPS="$(curl -s "https://www.cloudflare.com/ips-v4" && curl -s "https://www.cloudflare.com/ips-v6")"

# Enable Real IP Logging
echo "# Put these on \"http { ... }\" in \"/etc/nginx/nginx.conf\""
echo ""
echo "# Enable Real IP logging"
for CF_IP in ${CF_IPS}
do
	echo "set_real_ip_from ${CF_IP};"
done
echo "real_ip_header CF-Connecting-IP;"
echo ""

# Allow sources from Cloudflare IPs only
echo ""
echo "# Whitelist Rule: allow sources from Cloudflare IPs only"
echo "geo \$realip_remote_addr \$cloudflare_ips {"
echo "  default 0;"
for CF_IP in ${CF_IPS}
do
	echo "  ${CF_IP} 1;"
done
echo "}"
echo ""
echo "# Do not forget to add these confs on \"server { ... }\""
echo "#    if (\$cloudflare_ips != 1) {"
echo "#      return 403;"
echo "#    }"
