#!/bin/bash

# Requires `w3m` (apt install w3m)
# To setup as cron on my system with a web frontend:
# 0 * * * * curl --request GET 'https://localhost/phe/' >/dev/null 2>&1
# or through shell
# 0 * * * * /bin/sh /path/to/check.sh >/dev/null 2>&1
#
# web frontend can simply be a PHP file:  <?php passthru('/path/to/check.sh'); ?>

current=$(w3m -T text/html -dump https://www.phe.gov/emergency/news/healthactions/phe/Pages/default.aspx 2>/dev/null|grep "This page last reviewed:"|sed -e 's/.*: //g' 2>/dev/null)
hash=$(cat .phehash 2>/dev/null)


if [ "$current" = "$hash" ]; then
        echo "No change."
else
        echo "Change detected.";
        echo $current >.phehash
        echo "Update available, see: https://www.phe.gov/emergency/news/healthactions/phe/Pages/default.aspx" | mail -s 'Public Health Emergency' -a From:Rich\<no-reply@example.com\> 5555555555@txt.att.net
fi
