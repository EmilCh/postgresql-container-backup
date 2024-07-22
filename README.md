Example docker-compose.yml file
```
services:
  backup:
    image: ghcr.io/emilch/postgresql-container-backup:main
    restart: always
    volumes:
      - ./backup:/backup
    environment:
      PGSQL_USER: postgres
      PGSQL_PASS: postgrespassword
      PGSQL_HOST: postgresdb
```
