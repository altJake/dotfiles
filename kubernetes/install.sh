#!/usr/bin/env bash
# Install kubectl plugins via krew.

if command -v kubectl-krew &>/dev/null; then
  kubectl krew install neat
else
  echo "krew not found — install via Brewfile first, then re-run"
fi
