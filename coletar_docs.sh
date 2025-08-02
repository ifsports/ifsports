#!/bin/bash
set -e

DOCS_PROJECT_PATH="./ifsports-docs"
SPECS_DIR="$DOCS_PROJECT_PATH/source/_static/api-specs"
GATEWAY_URL="http://localhost"

# Django usa /api/schema/, FastAPI usa /openapi.json
SERVICES=(
  "auth:/auth/api/schema/"                  # Django
  "competitions:/competitions/api/schema/"  # Django
  "audit:/audit/api/schema/"                # Django
  "teams:/teams/openapi.json"               # FastAPI
  "requests:/requests/openapi.json"         # FastAPI
  "comments:/comments/openapi.json"         # FastAPI
  "calendar:/calendar/openapi.json"         # FastAPI
)

echo "🚀 Coletando especificações OpenAPI..."
mkdir -p "$SPECS_DIR"
for service_info in "${SERVICES[@]}"; do
  FILENAME=$(echo "$service_info" | cut -d: -f1)
  ROUTE=$(echo "$service_info" | cut -d: -f2)
  URL="$GATEWAY_URL$ROUTE"
  OUTPUT_FILE="$SPECS_DIR/$FILENAME.yml"
  echo "➡️  Buscando de $URL..."
  # O ideal é salvar como .json, mas .yml também funciona para a maioria das ferramentas
  curl -f -L "$URL" -o "$OUTPUT_FILE"
  echo "✅ Salvo em $OUTPUT_FILE"
done
echo "🎉 Coleta concluída!"