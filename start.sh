#!/bin/sh

# Apache
source /etc/sysconfig/httpd
/usr/sbin/httpd $OPTIONS

# Icinga config
prefix=/usr/local/icinga
exec_prefix=${prefix}
IcingaBin=${exec_prefix}/bin/icinga
IcingaCfgFile=${prefix}/etc/icinga.cfg
IcingaCommandFile=${prefix}/var/rw/icinga.cmd
IcingaRunFile=${prefix}/var/icinga.lock

# -d to daemonize
$IcingaBin $IcingaCfgFile
