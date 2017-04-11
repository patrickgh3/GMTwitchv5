/// tw_api_request(requesturl)
// Sends a Twitch API request like https://api.twitch.tv/kraken + requesturl
// Returns the http_request id.

var map = ds_map_create()
ds_map_add(map, 'Client-ID', clientid)
ds_map_add(map, 'Accept', 'application/vnd.twitchtv.v5+json')
var data = ''

var httpId = http_request('https://api.twitch.tv/kraken' + argument0, 'GET', map, data)

ds_map_destroy(map)

return httpId
