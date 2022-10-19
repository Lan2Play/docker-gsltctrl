#!/bin/bash

if [ "$APIKEY" = "unspecified" ]; then
    echo "You have to set the APIKEY env var"
    exit 1
fi

echo $APIKEY > APIKEY
python3 gsltctrl.py $@
