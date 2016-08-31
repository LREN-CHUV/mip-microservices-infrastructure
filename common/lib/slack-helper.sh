#!/bin/bash

# Parameter: stdin containing the JSON to send
function post-to-slack() {
  cat - > .slack.json
  curl -k -X POST --data-urlencode payload@.slack.json https://hbps1.chuv.ch/slack/dev-activity
  rm .slack.json
}

if [ -z "$SLACK_USER_NAME" ]; then
  SLACK_USER_NAME="@${USER}"
fi

export SLACK_USER_NAME
