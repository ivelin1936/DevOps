#!/bin/bash

#TODO: make it works with unknown number of beats as arguments 'https://stackoverflow.com/questions/4423306/how-do-i-find-the-number-of-arguments-passed-to-a-bash-script'

DISTRIBUTION=$1
BEAT=$2

DIR=${PWD}/beats
HOSTNAME_IP=$(hostname -i | awk '{print $2}')
echo "### Installing beats on host $HOSTNAME_IP..."

setupbeat() {
    BEAT_NAME=$1
    BEAT_SCRIPT_PATH="$DIR/$BEAT_NAME-$DISTRIBUTION.sh"
    SETUP_SCRIPT="$DIR/$BEAT_NAME-setup.sh"
    CUSTOM_BEAT_YML=$DIR/$BEAT_NAME
    ORIGINAL_BEAT_YML="/etc/$BEAT_NAME/$BEAT_NAME.yml"
    
    if [ -f "$BEAT_SCRIPT_PATH" ]; then 
        echo "Installing $BEAT_NAME:::..." 
        sudo bash $BEAT_SCRIPT_PATH
        
        if [ -f $SETUP_SCRIPT ]; then
            echo "Setting up $BEAT_NAME..."
            sudo bash $SETUP_SCRIPT
        else 
            echo "Not found $BEAT_NAME's setup script."
        fi
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

[ -d "$DIR" ] && applyBeats || echo "Shared dir '$DIR' not found"
