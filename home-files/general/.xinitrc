#!/bin/sh

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

exec herbstluftwm --locked
