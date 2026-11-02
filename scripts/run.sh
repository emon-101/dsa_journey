#!/usr/bin/env bash
# Usage: ./scripts/run.sh path/to/file.cpp
set -e
g++ -std=c++17 -O2 -Wall -Wextra "$1" -o /tmp/dsa_out && /tmp/dsa_out
