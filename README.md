# Dockerized repository

## Configuration

### Templated configuration

Configure variables in .env. See [.env.example](.env.example) for template.
Reasonable defaults are provided.
We provide detailed documentation for [variable-expansion](https://doc.linkurious.com/admin-manual/latest/configure/#variable-expansion)

You will most likely need to set your private repository host, if images are not available locally.

This mode has limitations and will be dropped in the future.

### Configuration overlay

As an alternative, you may put a partial configuration file in your data folder: `data/config/production-overlay.json`.
This file will be overlaid on top of your current production.json file. If no `production.json` file is provided, defaults will be generated.

Overlay file will take precedence on anything included in the main configuration file.
Values present in the overlay are no longer modifiable via the UI. Overlay file always takes precendenc.

As the final configuration is the result of the merge of two config files, you can possibly create an inconsistent configuration file, that will not pass validation, and thus prevent Linkurious Enterprise to start

See [Configuring Linkurious Enterpise](https://doc.linkurious.com/admin-manual/latest/configure/)

## Usage
  - Run with docker-compose
    ```
    $ docker-compose up -d
    ```
    Using automatically the docker-compose.override.yml file this will start lke-server + lke-frontend + neo4j

  - to start a full environment, on a server:
  ```
  docker-compose -f docker-compose.yml -f docker-compose.dev.yml -f docker-compose.neo4jsa.yml -f docker-compose.es.yml up
  ```

  - to start Linkurious Enterprise on local environment:
  ```
  docker-compose -f docker-compose.lke.yml up
  ```

  - to start Linkurious Enterprise on local environment, with Neo4j and ES:
  ```
  docker-compose -f docker-compose.lke.yml -f docker-compose.neo4jsa.yml -f docker-compose.es.yml up
  ```

## How to launch a feature branch
  - Clone this repo in a non existing directory, to avoid docker name collision with another LKE instance running :
  ```
  git clone git@github.com:Linkurious/docker-lke.git DIRECTORY_NAME
  ```
  - Configure .env and .env.lke-server.RUN_ENV to fit your needs - you can copy from files of another instance already configured. Note that the RUN_ENV variable in .env refers to the second env file: RUN_ENV=dev-lke-1234 will look for a .env.lke-server.dev-lke-1234 file
  - Side note : build numbers are PR numbers and not Jira issue IDs !
  - Create an fake empty licence file :
  ```
  touch license.key
  ```
  - If you never did it, log yourself into your registry so docker can pull the image:
  ```
  docker REGISTRY
  ```
  - If needed, remove existing volumes, keeping in mind that THIS DELETES ALL EXISTING DATA OF THIS LKE INSTANCE :
  ```
  docker-compose ... down -v
  ```

## Standalone ES for dev
In the case you need a standalone ES server for dev purposes, you can run:
```
docker-compose -f docker-compose.es.yml up -d
```
In the case your port 9200 is used, it will select one in the 92xx range.


## User datastore backups
If you would like to have your sqlite user datastore backed up, you can configure [litestream](https://litestream.io/) by provididing the appropriate .env.backup.${RUN_ENV} file, see [.env.backup.example](.env.backup.example) and adding:
```
-f docker-compose.backup.yml
```
to your stack up command

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


