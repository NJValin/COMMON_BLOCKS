#!/bin/sh -w

export PROJDIR="$HOME/IP/COMMON"
export SVLINT_CONFIG="$PROJDIR/.utils/.svlint.toml"
export SVLINT_INCDIRS="$PROJDIR"

if [ ! -d ".utils/venv" ]; then # if the directory doesn't exist
	python3 -m venv ./.utils/venv
	sed -i 's/(venv)/(IP)/g' ./.utils/venv/bin/activate
fi
source .utils/venv/bin/activate
