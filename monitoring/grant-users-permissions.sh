#!/bin/bash

# Este script concede as permissões necessárias para monitoramento e backup.

containers=("db_teams" "db_requests" "db_auth" "db_calendar" "db_competitions" "db_match_comments" "db_audit")
users=("postgres" "IntegradorEstelar_42" "auth_user" "IntegradorMundial_87" "IntegradorGalatico_77" "IntegradorInternacional_94" "audit_user")
databases=("db_teams" "db_requests" "auth_db" "db_calendar" "db_competitions" "db_match_comments" "audit_db")

echo "Iniciando a concessão de permissões..."

for i in "${!containers[@]}"; do
  container="${containers[$i]}"
  user="${users[$i]}"
  database="${databases[$i]}"

  if [[ "$user" == *"_"* ]]; then
    sql_user="\"$user\""
  else
    sql_user="$user"
  fi

  # --- Comando SQL Atualizado com permissão de SELECT ---
  sql_command="
    GRANT pg_monitor TO $sql_user; 
    GRANT EXECUTE ON FUNCTION pg_catalog.pg_postmaster_start_time() TO $sql_user; 
    GRANT CONNECT ON DATABASE $database TO $sql_user;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO $sql_user;
  "
  # Adicionamos 'GRANT SELECT' para permitir a leitura das tabelas para o backup.

  echo "-----------------------------------------------------"
  echo "Aplicando permissões no contêiner: $container"
  echo "Usuário: $user | Banco de Dados: $database"
  
  docker exec "$container" psql -U "$user" -d "$database" -c "$sql_command"
  
  if [ $? -eq 0 ]; then
    echo "Permissões aplicadas com sucesso."
  else
    echo "ERRO ao aplicar permissões no contêiner $container."
  fi
done

echo "-----------------------------------------------------"
echo "Processo finalizado."