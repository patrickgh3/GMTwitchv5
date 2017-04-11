/// tw_api_response()
// Handles HTTP event. Sets requestId, jsonmap.
// Returns true if just recieved and prepared API response, else false.

var status = async_load[? 'status']
requestid = async_load[? 'id']
if status != 0 {
    show_debug_message('http status nonzero, requestid='+string(requestid))
    return false
}

// Check if the url contains 'twitch.tv'
var url = async_load[? 'url']
if string_pos('twitch.tv', url) != 0 {
    var str = async_load[? 'result']
    jsonmap = json_decode(str)
    
    // Check for standard Twitch error format
    var error = jsonmap[? 'error']
    if not is_undefined(error) {
        show_debug_message('Error response, requestid='+string(requestid)+' text='+str)
        return false
    }
    
    return true
}

return false
