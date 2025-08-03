#!/bin/bash
set -e

DOCS_PROJECT_PATH="./ifsports-docs"
SPECS_DIR="$DOCS_PROJECT_PATH/source/_static/api-specs"
GATEWAY_URL="http://35.215.219.1"

# Os caminhos agora correspondem às rotas criadas no Kong,
# e o path final da schema é concatenado no script.
SERVICES=(
  "auth:/docs/auth/api/schema/"
  "competitions:/docs/competitions/api/schema/"
  "audit:/docs/audit/api/schema/"
  "teams:/docs/teams/openapi.json"
  "requests:/docs/requests/openapi.json"
  "comments:/docs/comments/openapi.json"
  # "calendar:/docs/calendar/openapi.json"
)

echo "🚀 Coletando especificações OpenAPI..."
mkdir -p "$SPECS_DIR"
for service_info in "${SERVICES[@]}"; do
  FILENAME=$(echo "$service_info" | cut -d: -f1)
  ROUTE=$(echo "$service_info" | cut -d: -f2)
  URL="$GATEWAY_URL$ROUTE"
  OUTPUT_FILE="$SPECS_DIR/$FILENAME.yml"
  
  echo "➡️  Buscando de $URL..."
  # Usando -S para mostrar erros e -s para silenciar o progresso
  if curl -fsSL "$URL" -o "$OUTPUT_FILE"; then
    echo "✅ Salvo em $OUTPUT_FILE"
  else
    echo "❌ Falha ao buscar de $URL"
  fi
done
echo "🎉 Coleta concluída!"