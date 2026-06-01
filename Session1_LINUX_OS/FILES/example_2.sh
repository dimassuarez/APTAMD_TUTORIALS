#!/bin/bash

# Input arguments
INPUT_FILE=$1
SIEVE=$2
# Output argument
OUTPUT_FILE=$3

if [ -z "$INPUT_FILE" ] || [ -z "$SIEVE" ] || [ -z "$OUTPUT_FILE" ]; then
    echo "Usage: $0 input sieve output"
    exit 1
fi

if [ "$SIEVE" -le 1 ]; then
    echo "SIEVE must be > 1"
    exit 1
fi
NLINES_INPUT=$(wc -l < "$INPUT_FILE")
echo "$INPUT_FILE contains $NLINES_INPUT lines"
echo "Using SIEVE = 1  of every $SIEVE"
awk -v sieve="$SIEVE" 'NR % sieve == 1' "$INPUT_FILE" > "$OUTPUT_FILE"
echo "$OUTPUT_FILE contains $(wc -l< $OUTPUT_FILE) lines "

