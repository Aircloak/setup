function secret {
  cat /dev/urandom |
    LC_CTYPE=C tr -dc 'a-zA-Z0-9' |
    fold -w 64 |
    head -n 1
}

echo "Updating secrets in 'config/air/config.json'."
config=$(< config/air/config.json)
echo $config | jq --arg new_secret "`secret`" '.site.auth_secret |= $new_secret' \
 | jq --arg new_secret "`secret`" '.site.endpoint_key_base |= $new_secret' \
 | jq --arg new_secret "`secret`" '.site.api_token_salt |= $new_secret' \
 > config/air/config.json

echo "Updating salt in 'config/cloak/config.json'."
config=$(< config/cloak/config.json)
echo $config | jq --arg new_secret "`secret`" '.salt |= $new_secret' > config/cloak/config.json

echo "All secrets updated."
