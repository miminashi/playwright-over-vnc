#!/bin/bash

# Start Xvfb with consistent display (matches environment variable in Dockerfile)
xvfb-run -e /dev/stdout -s "-screen 0 1280x1024x24 -ac -nolisten tcp -nolisten unix" "playwright open https://blog.sh1ma.dev"  &

# Display is already set as ENV in Dockerfile

# Start fluxbox (lightweight window manager)
fluxbox &

# Start VNC server
x11vnc -display :1 -nopw -localhost -xkb -ncache 10 -ncache_cr -create -forever &

# Start noVNC (using the system installed version)
/usr/share/novnc/utils/novnc_proxy --vnc localhost:5900 --listen 6080 &

# Keep the script running
tail -f /dev/null