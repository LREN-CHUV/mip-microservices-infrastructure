#!/bin/bash

# Helper that transforms the list of tags selected and excluded from an ansible-playbook command
# into a human readable message.

PLAYBOOK_COMPONENTS="All"
PLAYBOOK_HOSTS=""
skip_tags=""

while [ ! -z "$1" ]; do
    case "$1" in
        --tags=*)
            tags="${1#*=}"
            PLAYBOOK_COMPONENTS="$tags"
            if [ ! -z "$skip_tags" ]; then
              PLAYBOOK_COMPONENTS="$PLAYBOOK_COMPONENTS except $skip_tags"
            fi
            break
            ;;
        --skip-tags=*)
            skip_tags="${1#*=}"
            PLAYBOOK_COMPONENTS="$PLAYBOOK_COMPONENTS except $skip_tags"
            break
            ;;
        --limit=.*)
            limit="${1#*=}"
            PLAYBOOK_HOSTS="limited to $limit"
            break
            ;;
        -l)
            shift
            limit="$1"
            PLAYBOOK_HOSTS="limited to $limit"
            break
            ;;
        *) ;;
    esac
    shift
done

export PLAYBOOK_COMPONENTS
export PLAYBOOK_HOSTS
