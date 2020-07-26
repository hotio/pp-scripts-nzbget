#!/bin/bash

################################################################################
### NZBGET POST-PROCESSING SCRIPT                                            ###

# Change permissions, owner/group and reset timestamps.
#
# This script changes the permissions and owner/group of your downloads,
# it can also reset the timestamps.
#
# NOTE: This script requires bash, find, chmod, chown and touch to be installed on your system.

################################################################################
### OPTIONS                                                                  ###

# Change permissions using symbolic notation.
#
# Leave empty to disable changing the permissions.
#Permissions=ug=rwX,o=

# Change owner/group.
#
# Leave empty to disable changing the owner/group.
#Owner=

# Reset the timestamps or keep them unchanged (Reset, Unchanged).
#Timestamps=Reset

### NZBGET POST-PROCESSING SCRIPT                                            ###
################################################################################

EXITCODE=93

# set permissions
if [[ ! -z $NZBPO_PERMISSIONS ]]; then
    echo "[INFO] Setting permissions to ($NZBPO_PERMISSIONS) for $NZBPP_NZBNAME"
    chmod -R "$NZBPO_PERMISSIONS" "$NZBPP_DIRECTORY"
    if [[ $? != 0 ]]; then
        echo "[ERROR] Setting permissions to ($NZBPO_PERMISSIONS) for $NZBPP_NZBNAME failed!"
        EXITCODE=94
    fi
fi

# set owner/group
if [[ ! -z $NZBPO_OWNER ]]; then
    echo "[INFO] Setting owner/group to ($NZBPO_OWNER) for $NZBPP_NZBNAME"
    chown -R "$NZBPO_OWNER" "$NZBPP_DIRECTORY"
    if [[ $? != 0 ]]; then
        echo "[ERROR] Setting owner/group to ($NZBPO_OWNER) for $NZBPP_NZBNAME failed!"
        EXITCODE=94
    fi
fi

# reset timestamps
if [[ $NZBPO_TIMESTAMPS == "Reset" ]]; then
    echo "[INFO] Resetting timestamps for $NZBPP_NZBNAME"
    find "$NZBPP_DIRECTORY" -type f -exec touch {} \;
    if [[ $? != 0 ]]; then
        echo "[ERROR] Resetting timestamps for $NZBPP_NZBNAME failed!"
        EXITCODE=94
    fi
fi

# exit with received exitcode
exit $EXITCODE
