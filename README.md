# Dockerized repository

## Configuration
  - Configure variables in .env. See .env.example for template.
Reasonable defaults are provided.

## Usage
  - Run with docker-compose
    ```
    $ docker-compose up -d
    ```

## Bind mounts

### MacOsX

You will need to configure shared paths : 
You can configure shared paths from Docker -> Preferences... -> File Sharing.
See https://docs.docker.com/docker-for-mac/osxfs/#namespaces for more info.

### neo4j data migrations
When importing old databases you might have to perform an upgrade.
There are specific update paths to be followed, such as 2.2 -> 3.2 -> 3.5.15.
The name of the var alowing migrotions has changed over time:

`/var/lib/neo4j/bin/neo4j-admin import --mode=database --database=graph.db --from=/crunchdb/crunchbase.db`

`echo dbms.allow_format_migration=true >> /var/lib/neo4j/conf/neo4j.conf`

`echo dbms.allow_upgrade=true >> /var/lib/neo4j/conf/neo4j.conf`


