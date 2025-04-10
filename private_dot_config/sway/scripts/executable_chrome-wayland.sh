#!/bin/bash
export XDG_SESSION_TYPE=wayland
export XCURSOR_THEME=phinger-cursors-light
export XCURSOR_SIZE=36
exec /usr/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland "$@"
