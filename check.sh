#!/bin/bash

# Requires `w3m` (apt install w3m)

current=$(w3m -T text/html -dump https://www.phe.gov/emergency/news/healthactions/phe/Pages/default.aspx|grep "This page last reviewed:"|sed -e 's/.*: //g' 2>/dev/null)
hash=$(cat .phehash 2>/dev/null)


if [ "$current" = "$hash" ]; then
        echo "No change."
else
        echo "Change detected.";
        echo $current >.phehash
        echo "Update available, see: https://www.phe.gov/emergency/news/healthactions/phe/Pages/default.aspx" | mail -s 'Public Health Emergency' -a From:Rich\<no-reply@example.com\> 5555555555@txt.att.net
fi
