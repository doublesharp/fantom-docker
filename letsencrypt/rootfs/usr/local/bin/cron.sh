#!/usr/bin/env bash

. /usr/local/bin/helper-functions

info '🗄️ installing Database cron jobs'
crontab /initjobs.d/jobs.txt

# start cron
info '⏰ starting crond'
/usr/sbin/crond -f -l 2
