#!/bin/sh
#
# Startup script for the <span class='wp_keywordlink_affiliate'><a href="http://itgeeker.net/tag/dns/" title="View all posts in DNS" target="_blank">DNS</a></span> caching server
#
# chkconfig: - 49 50
# description: This script starts your DNS caching server
# processname: dnsmasq
# pidfile: /var/run/dnsmasq
# Source function library.
. /etc/rc.d/init.d/functions
# Source networking configuration.
. /etc/sysconfig/network
# Check that networking is up.
[ ${NETWORKING} = "no" ] && exit 0
dnsmasq=/usr/local/sbin/dnsmasq
[ -f $dnsmasq ] || exit 0
RETVAL=0
# See how we were called.
case "$1" in
start)
if [ $UID -ne 0 ] ; then
echo "User has insufficient privilege."
exit 4
fi
echo -n "Starting dnsmasq: "
daemon $dnsmasq $OPTIONS
RETVAL=$?
echo
[ $RETVAL -eq 0 ] && touch /var/lock/subsys/dnsmasq
;;
stop)
if test "x`pidof dnsmasq`" != x; then
echo -n "Shutting down dnsmasq: "
killproc dnsmasq
fi
RETVAL=$?
echo
[ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/dnsmasq /var/run/dnsmasq.pid
;;
status)
status dnsmasq
RETVAL=$?
;;
reload)
echo -n "Reloading dnsmasq: "
killproc dnsmasq -HUP
RETVAL=$?
echo
;;
force-reload)
# new configuration takes effect only after restart
$0 stop
$0 start
RETVAL=$?
;;
restart)
$0 stop
$0 start
RETVAL=$?
;;
condrestart)
if test "x`/sbin/pidof dnsmasq`" != x; then
$0 stop
$0 start
RETVAL=$?
fi
;;
*)
echo "Usage: $0 {start|stop|restart|reload|condrestart|status}"
exit 2
esac
exit $RETVAL
