#!/usr/bin/env bash
cd /tmp
git clone https://github.com/perusio/nginx_ensite.git
cp nginx_ensite/bin/nginx_ensite nginx_ensite/bin/nginx_dissite /usr/bin
cp nginx_ensite/share/man/man8/nginx_* /usr/share/man/man8
cp nginx_ensite/bash_completion.d/nginx_ensite /etc/bash_completion.d
rm -rf nginx_ensite
