#!/bin/bash -i

echo $APIKEY > APIKEY
python3 gsltctrl.py $@
