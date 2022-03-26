#!/bin/bash

#!/bin/bash

DIR=${PWD}/beats
HOSTNAME_IP=$(hostname -i | awk '{print $2}')
echo "### Installing beats on host $HOSTNAME_IP..."

metricbeat() {
    METRICBEAT="$DIR/metricbeat_centos_setup.sh"
    CUSTOM_METRICBEAT_YML="$DIR/metricbeat.yml"
    ORIGINAL_YML_CONF="/etc/metricbeat/metricbeat.yml"

    [ -f "$METRICBEAT" ] && echo "Installing metricbeat:::..." && source $METRICBEAT || echo "File '$METRICBEAT' not found. Current dir: '${PWD}'"
    if [ -f $CUSTOM_METRICBEAT_YML ]; then
        echo "::::: Custom configuration file '$CUSTOM_METRICBEAT_YML' detected!"
        echo "Applying custom configuration..."
        sudo cp -f $CUSTOM_METRICBEAT_YML $ORIGINAL_YML_CONF
    else 
        echo "Not found custom configuration file '$CUSTOM_METRICBEAT_YML'."
    fi
}

applyBeats() {
    metricbeat
}

[ -d "$DIR" ] && applyBeats|| echo "Shared dir '$DIR' not found"
