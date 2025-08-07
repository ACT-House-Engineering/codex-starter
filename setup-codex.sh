#!/bin/bash

# Paste these commands in the Codex Setup field to run this script
# chmod +x ./setup-codex.sh
# ./setup-codex.sh

# Codex Default Docker Image
# https://github.com/openai/codex-universal/tree/main

# Log latest commit so that we can see where codex is at
# relative to everything else
git log -1

# Create .env.local file with fake values to pass local CI Checks
echo "NEXT_PUBLIC_CLERK_PUBLISHABLE_KEY=pk_test_Y2xlcmsuZXhhbXBsZS5jb20k" > .env.local
echo "CLERK_SECRET_KEY=sk_test_Y2xlcmsuZXhhbXBsZS5jb20k" >> .env.local
echo "NEXT_PUBLIC_CONVEX_URL=https://example.convex.cloud" >> .env.local

# update to latest pnpm
curl -fsSL https://get.pnpm.io/install.sh | bash -

# There's some issue with onnxruntime-node blocking the install so we're ignoring all scripts for now
# 
# Onnx runtime install script
# https://github.com/microsoft/onnxruntime/blob/5c97cb11ae22b9d0bc28b22db847d82ca01a1c85/js/node/script/install.js
# 
# Deekwiki research
# https://deepwiki.com/search/does-it-fetch-anything-during_49598d8a-4e25-4f33-bed2-7d9b04e01759

# Install deps
pnpm install --frozen-lockfile --ignore-scripts
