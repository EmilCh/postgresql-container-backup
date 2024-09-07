#!/bin/bash

# Postgres configuration (replace with your details)
PGUSER="your_username"
PGHOST="your_hostname"
PGPORT="5432"
export PGPASSWORD="your_password"
BACKUPDIR="/backup"
EXCLUDE_DBS="template0 template1 postgres"  # Exclude these databases

# Get date in YYYY-MM-DD format
CURRENTDATE=$(date +%Y-%m-%d)

# Function to backup a single database
backup_database() {
  local db_name="$1"
  local backup_file="$BACKUPDIR/$CURRENTDATE-$db_name.sql.gz"

  # Skip excluded databases
  if [[ "$EXCLUDE_DBS" =~ " $db_name " ]]; then
    echo "Skipping excluded database: $db_name"
    return
  fi

  # Dump the database
  pg_dump -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" "$db_name" | gzip > "$backup_file"
  echo "Backup completed: $backup_file"
}

# Ensure backup directory exists
mkdir -p "$BACKUPDIR"

# Get list of databases (excluding template and postgres)
databases=$(psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;")

# Loop through databases and backup each one
for db_name in $databases; do
  backup_database "$db_name"
done

# Delete backups older than 60 days
find "$BACKUPDIR" -type f -name "*.sql.gz" -mtime +30 -delete

echo "Deleted old backups from $BACKUPDIR"
