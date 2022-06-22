#!/usr/bin/env bash

set -euo pipefail

if [ -n "${PARAMETER_STORE:-}" ]; then
  export INGRESOS_CRUD_DB_USER="$(aws ssm get-parameter --name /${PARAMETER_STORE}/ingresos_crud/db/username --output text --query Parameter.Value)"
  export INGRESOS_CRUD_DB_PASS="$(aws ssm get-parameter --with-decryption --name /${PARAMETER_STORE}/ingresos_crud/db/password --output text --query Parameter.Value)"
fi

exec ./main "$@"
