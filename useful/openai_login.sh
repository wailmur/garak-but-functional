#!/bin/bash

eval 'export OPENAI_API_KEY="[your_openai_key]"'

if [ -n "$OPENAI_API_KEY" ]; then
        echo "OPENAI API KEY: $OPENAI_API_KEY"
else
        echo "Error: OPENAI API KEY was not set."
fi