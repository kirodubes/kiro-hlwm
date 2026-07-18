#!/bin/bash
if pgrep -x "fastcompmgr" > /dev/null
then
	killall fastcompmgr
else
	fastcompmgr -c &
fi
