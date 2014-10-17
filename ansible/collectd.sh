#!/usr/bin/env bash

COLLECTD=collectd  # /usr/sbin/collectd on linux, /usr/local/sbin/collectd on freebsd
CONFIG_FILE=/opt/mistio-collectd/collectd.conf
PID_FILE=/opt/mistio-collectd/pid

start() {
  if [ -f $PID_FILE ] && ps -p $(cat $PID_FILE); then
    echo "mist.io collectd already running"
    cat $PID_FILE
    return 1
  fi
  echo "Starting mist.io collectd"
  $COLLECTD -C $CONFIG_FILE -P $PID_FILE
  sleep 1
  cat $PID_FILE
}

stop() {
  if [ ! -f $PID_FILE ] || ! ps -p $(cat $PID_FILE); then
    echo 'mist.io collectd not running'
    return 1
  fi
  echo 'Stopping mist.io collectd'
  kill $(cat $PID_FILE) && rm -f $PID_FILE
}

status() {
  if [ ! -f $PID_FILE ] || ! ps -p $(cat $PID_FILE); then
    echo "mist.io stopped"
    return 1
  fi
  echo "mist.io collectd running"
  cat $PID_FILE
}

case "$1" in
  start)
    start
  ;;
  stop)
    stop
  ;;
  restart)
    stop
    start
  ;;
  status)
    status
  ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
esac
