#!/bin/sh
# Automatisch on Railway: one image, two roles (web+API, worker), picked by WORKER.
set -e

cd /automatisch/packages/backend

if [ -n "$WORKER" ]; then
  exec yarn start:worker
fi

yarn db:migrate
node --loader ./alias-loader.mjs ./bin/database/seed-admin.js
exec yarn start
