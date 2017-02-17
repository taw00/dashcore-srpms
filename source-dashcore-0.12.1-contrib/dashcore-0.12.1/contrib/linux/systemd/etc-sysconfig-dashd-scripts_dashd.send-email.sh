#!/usr/bin/sh
#
# This is executed by systemd as defined in dashd.service
#
# This will send an email "from" EMAIL_FROM, "to" EMAIL_TO, and will have
# MASTERNODE_ALIAS as a subject line differentiator.
#
# Do not edit this file. These values are instead configured in
# /etc/sysconfig/dashd
#

EMAIL_FROM=$2
EMAIL_TO=$3
MASTERNODE_ALIAS=$4

DATE_LOG=$(/usr/bin/date --utc +"%b %d %T UTC")


start() {
  if [[ ! -z $EMAIL_FROM && ! -z $EMAIL_TO && ! -z $MASTERNODE_ALIAS ]] ; then
    /usr/bin/echo "sending systemd-managed dashd start email- $DATE_LOG"
    /usr/bin/echo "Notification: systemd-managed dashd start" | /usr/bin/mail -S sendwait -s "[$MASTERNODE_ALIAS] dashd.service started - $DATE_LOG" -r $EMAIL_FROM $EMAIL_TO >> /dev/null 2>&1
  fi
}


stop() {
  if [[ ! -z $EMAIL_FROM && ! -z $EMAIL_TO && ! -z $MASTERNODE_ALIAS ]] ; then
    /usr/bin/echo "sending systemd-managed dashd stop email- $DATE_LOG"
    /usr/bin/echo "Notification: systemd-managed dashd stop" | /usr/bin/mail -S sendwait -s "[$MASTERNODE_ALIAS] dashd.service stopped - $DATE_LOG" -r $EMAIL_FROM $EMAIL_TO >> /dev/null 2>&1
  fi
}


case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  *) exit 1
esac

