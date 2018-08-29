- HTTPS (letsencrypt) for air service/loadbalancer
  - can we use an ingress for the http part
  - and can we expose 5432 using the loadbalancer
- inject 'ID' into cloak deployment/container

- fix the way we start the air, do not use a secret
  - use configmaps for non-sensitive content

- snippets contains the commands to create the secrets, make that a bash script
- start_the_air.sh shell script is used to bring up the air, permission topic, we'll find a better solution
  - can we run the container as deployer:deployer
==== > running version/ accessible worldwide ;)

==> cleanup phase / beautify

NOTE: config.json for air was updated to match the air-db service

 ❯ cat docker-compose/config/air/config.json                                                                                     [16:09:02]
{
  "database": {
    "host": "air-db",
    "port": 7432,
}}
