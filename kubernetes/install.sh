#!/usr/bin/env bash
# Install kubectl plugins via krew.

if (( $+commands[kubectl-krew] )); then
  kubectl krew install neat
else
  echo "krew not found — install via Brewfile first, then re-run"
fi
