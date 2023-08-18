# Cloudflare Nginx Configuration

### cf-nginx-confmaker.sh
```
bash cf-nginx-confmaker.sh > /etc/nginx/cloudflareips.conf
```

Then add configuration below on `http { ... }` in `/etc/nginx/nginx.conf`.
```
include /etc/nginx/cloudflareips.conf;
```

Add blocking condition on `server { ... }` (in virtual host or etc).
```
  if ($cloudflare_ips != 1) {
    return 403;
  }
```
