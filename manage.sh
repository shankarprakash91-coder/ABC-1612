#!/bin/bash

INPUT=$1
DIR="$HOME/abc-data"

if [ "$INPUT" -eq 1 ]; then
    echo "Creating directory and file"

    mkdir -p $DIR
    touch $DIR/data.txt

    echo "File created at $DIR/data.txt"

elif [ "$INPUT" -eq 0 ]; then
    echo "Deleting directory"

    rm -rf $DIR

    echo "Directory deleted"

else
    echo "Invalid input"
fi
