#!/bin/sh
set -e

# Register a Brother network scanner with brscan4 before handing off to the
# stock scanservjs entrypoint. Example: BRSCAN_NAME=E514dw
# BRSCAN_MODEL=MFC-L2700DW BRSCAN_IP=192.168.1.43
if [ -n "$BRSCAN_NAME" ] && [ -n "$BRSCAN_MODEL" ] && [ -n "$BRSCAN_IP" ]; then
  brsaneconfig4 -a name="$BRSCAN_NAME" model="$BRSCAN_MODEL" ip="$BRSCAN_IP"
fi

exec /entrypoint.sh
