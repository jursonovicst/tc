#!/usr/bin/env bash

ROLEFILE=/etc/tcrole

if [ -c $ROLEFILE ]
then
  echo "tcrole=$(cat $ROLEFILE)"
fi