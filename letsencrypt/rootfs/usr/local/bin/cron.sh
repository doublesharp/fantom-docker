#!/usr/bin/env bash

. /usr/local/bin/helper-functions

info '🗄️ Installing Database cron jobs'
crontab /initjobs.d/jobs.txt

# start cron
info '⏰ Starting crond'
/usr/sbin/crond -f -l 2
