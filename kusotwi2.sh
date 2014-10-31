#!/bin/sh
#
#
#


port1=17

message1="aaaaaaaaaaaaaatesttest圧迫面接ジャム作りsinyouju   `date +%H:%M`"
#message1="redbu11"

gpio -g mode $port1 in

echo "push button"

while true ; do

  btn1=`gpio -g read $port1`

  if [ $btn1 -eq 1 ] ; then
    haltflag=1
    for i in 0 1 2 3 4 5
    do
      sleep 0.5
      btn2=`gpio -g read $port1`
      if [ $btn2 -eq 0 ] ; then
         haltflag=0
      fi
    done
    if [ $haltflag -eq 1 ] ; then
      sudo halt
    fi
    tweet="$message1"
    echo "tweet [$message1]"
    ttytter -ssl -status="$tweet"
    echo "tweet complete."
    sleep 5
  fi
  sleep 0.1
done
