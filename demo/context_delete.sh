# To do: multiple contextUid in context.json
source assets.sh \
curl -X DELETE \
	https://api.smartling.com/context-api/v2/projects/$projectId/contexts/${contextUid} \
	-H 'cache-control: no-cache' \
	-H 'content-type: application/json' \
	-H "authorization: Bearer $accessToken"