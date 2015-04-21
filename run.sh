#!/bin/sh

# Helper script to run the sample app locally, assumes a local mysql instance with a
# login of root/root
if [ -z "${POSTGRESQL_DATABASE}" ]; then
  export DATABASE_SERVICE_HOST=localhost
  export DATABASE_SERVICE_PORT=5432
  export POSTGRESQL_DATABASE=test
  export POSTGRESQL_USER=root
  export POSTGRESQL_PASSWORD=root
fi

bundle exec ruby app.rb
