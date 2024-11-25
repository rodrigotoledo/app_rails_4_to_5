#!/usr/bin/env bash
set -xeuo pipefail
./bin/wait-for-tcp.sh redis 6379

chown -R appuser:appuser ./*

if [[ -f ./tmp/pids/server.pid ]]; then
  rm ./tmp/pids/server.pid
fi

bundle

if ! [[ -f .db-created ]]; then
  bin/rake db:drop db:create
  touch .db-created
fi

bin/rake db:migrate

if ! [[ -f .db-seeded ]]; then
  bin/rake db:seed
  touch .db-seeded
fi

rails s -b 0.0.0.0 -p 3000