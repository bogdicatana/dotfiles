#!/bin/bash

# Check if ags is running
if pgrep -x "ags" > /dev/null; then
    ags -q
else
    ags &
fi
