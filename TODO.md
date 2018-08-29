- fix the way we start the air, do not use a secret
- snippets contains the commands to create the secrets, make that a bash script
- start_the_air.sh shell script is used to bring up the air, permission topic, we'll find a better solution
  - can we run the container as deployer:deployer
- air service
- cloak installation
- postgres ports
- ingress (to connect from the outside world)

==== > running version/ accessible worldwide ;)

==> cleanup phase / beautify

NOTE: config.json for air was updated to match the air-db service

 ❯ cat docker-compose/config/air/config.json                                                                                     [16:09:02]
{
  "database": {
    "host": "air-db",
    "port": 7432,
}}
