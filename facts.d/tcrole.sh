#!/usr/bin/env bash

ROLEFILE=/etc/tcrole

if [ -f $ROLEFILE ]
then
  echo "tcrole=$(cat $ROLEFILE)"
fi