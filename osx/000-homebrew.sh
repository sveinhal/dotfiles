#!/bin/bash

if [[ "$(uname)" == "Darwin" ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
  # export PATH=$PATH:/opt/homebrew/bin/else
fi
