#!/bin/sh

set -eu

if [ -z "$INPUT_PULL_REQUEST_ID" ]; then
    pull_request_id="$(jq "if (.issue.number != null) then .issue.number else .number end" < "$GITHUB_EVENT_PATH")"

    if [ "$pull_request_id" = "null" ]; then
        echo "Failed to get pull request number from context, exiting..."
        exit 0
    fi
else
    pull_request_id="$INPUT_PULL_REQUEST_ID"
fi

python3 generate_pr.py \
    --github-api-url "$GITHUB_API_URL" \
    --github-token "$INPUT_GITHUB_TOKEN" \
    --pull-request-id "$pull_request_id" \
    --github-repository "$GITHUB_REPOSITORY" \
    --openai-api-key "$INPUT_OPENAI_API_KEY" \