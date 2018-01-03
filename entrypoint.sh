#!/bin/bash

# APP_HOME from environment
APP_HOME=${APP_HOME}

DEFAULT_CONFIG="${APP_HOME}/etmain/etl_server_default.cfg"
MOUNTED_CONFIG="${APP_HOME}/conf/etl_server.cfg"
RUNTIME_CONFIG="${APP_HOME}/etmain/etl_server.cfg"

cd ${APP_HOME}
if [ ! -f "$MOUNTED_CONFIG" ]; then
    echo "Providing default config '$DEFAULT_CONFIG' ..."
    cp "$DEFAULT_CONFIG" "$MOUNTED_CONFIG"
fi

if [ -f "$MOUNTED_CONFIG" ]; then
    echo "Using provided config at '$MOUNTED_CONFIG'"
    cp "$MOUNTED_CONFIG" "$RUNTIME_CONFIG"
else
    echo "WARNING: Could not copy default config '$DEFAULT_CONFIG' to mounted config '$MOUNTED_CONFIG'. Only using default config."
    cp "$DEFAULT_CONFIG" "$RUNTIME_CONFIG"
fi

./etlded_bot.sh
