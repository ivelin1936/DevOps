#!/bin/bash

DISTRIBUTION=$1
BEAT=$2

DIR=${PWD}/beats
HOSTNAME_IP=$(hostname -i | awk '{print $2}')
echo "### Installing beats on host $HOSTNAME_IP..."

setupbeat() {
    BEAT_NAME=$1
    BEAT_SCRIPT_PATH="$DIR/$BEAT_NAME-$DISTRIBUTION.sh"
    CUSTOM_BEAT_YML="$DIR/$BEAT_NAME.yml"
    ORIGINAL_BEAT_YML="/etc/$BEAT_NAME/$BEAT_NAME.yml"

    if [ -f "$BEAT_SCRIPT_PATH" ]; then 
        echo "Installing $BEAT_NAME:::..." 
        sudo source $BEAT_SCRIPT_PATH
    else
        echo "File '$BEAT_SCRIPT_PATH' not found. Current dir: '${PWD}'"
    fi
    
    if [ -f $CUSTOM_BEAT_YML ]; then
        echo "::::: Custom configuration file '$CUSTOM_BEAT_YML' detected!"
        echo "Applying custom configuration..."
        sudo cp -f $CUSTOM_BEAT_YML $ORIGINAL_BEAT_YML
    else 
        echo "Not found custom configuration file '$CUSTOM_BEAT_YML'."
    fi
}

applyBeats() {
    setupbeat $BEAT
}

[ -d "$DIR" ] && applyBeats|| echo "Shared dir '$DIR' not found"
