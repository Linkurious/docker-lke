# Dockerized repository

## Configuration
Configure variables in .env. See .env.example for template.
Reasonable defaults are provided.

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

## How to launch a feature branch
  - Clone this repo
  - Change the created directory's name to avoid docker name collision with another LKE instance running
  - Configure .env and .env.lke-server.XXXX to fit your needs - you can copy from files of another instance already configured
  - Side note : build numbers are PR numbers and not Jira issue IDs !
  - Create an fake empty licence file : 
  ```
  $ touch license.key
  ```
  - If you never did it, log yourself in nexus so docker can be pulled from it :
  ```
  $ docker login hub.docker.nexus3.linkurious.net
  ```
  - If the branch has run before, or if any doubt, remove existing volumes :
  ```
  $ docker-compose ... down -v
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


