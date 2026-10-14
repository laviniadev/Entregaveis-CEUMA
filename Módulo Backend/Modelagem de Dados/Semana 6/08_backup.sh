#!/usr/bin/env bash

# Backup lógico customizado do banco do Sistema Acadêmico.
set -u

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DB_NAME="${DB_NAME:-sistema_academico}"
DB_USER="${DB_USER:-postgres}"
BACKUP_DIR="${BACKUP_DIR:-${SCRIPT_DIR}/backups}"
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
BACKUP_FILE="${BACKUP_DIR}/${DB_NAME}_${TIMESTAMP}.dump"

if ! mkdir -p -- "$BACKUP_DIR"; then
    echo "Erro: não foi possível criar o diretório de backup: $BACKUP_DIR" >&2
    exit 1
fi

if pg_dump -U "$DB_USER" -d "$DB_NAME" -Fc -f "$BACKUP_FILE"; then
    echo "Backup realizado com sucesso: $BACKUP_FILE"
else
    status=$?
    echo "Erro: pg_dump falhou (código $status)." >&2
    rm -f -- "$BACKUP_FILE"
    exit "$status"
fi

if ! find "$BACKUP_DIR" -type f -name '*.dump' -mtime +30 -delete; then
    echo "Aviso: não foi possível remover todos os backups .dump com mais de 30 dias." >&2
    exit 1
fi

exit 0
