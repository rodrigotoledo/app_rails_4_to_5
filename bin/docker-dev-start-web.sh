#!/usr/bin/env bash
set -xeuo pipefail
./bin/wait-for-tcp.sh redis 6379

chown -R appuser:appuser ./*

if [[ -f ./tmp/pids/server.pid ]]; then
  rm ./tmp/pids/server.pid
fi

bundle

if ! [[ -f .db-created ]]; then
  bin/rails db:drop db:create
  touch .db-created
fi

bin/rails db:migrate

if ! [[ -f .db-seeded ]]; then
  bin/rails db:seed
  touch .db-seeded
fi

rails s