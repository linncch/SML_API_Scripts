curl -X POST \
  https://api.smartling.com/auth-api/v2/authenticate \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json' \
  -o tokens.json \
  -d @hu-post.json

  echo -e $green"The tokens have been saved in \"tokens.json\"."$none