#!/bin/bash

. ./config.sh
. ./commands.sh

envsubst < $1
