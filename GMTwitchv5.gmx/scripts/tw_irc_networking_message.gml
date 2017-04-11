/// tw_irc_networking_message
// Handles Networking event. Sets variables documented in tw_irc_parse_message().
// Returns true if just received and parsed chat message, else false.

var sockId = async_load[? 'id']
if sockId == ircsocket {
    var data = async_load[? 'buffer']
    var str = buffer_read(data, buffer_string)
    tw_irc_parse_message(str)
    if ircmessagetype == 'message' {
        return true
    }
}
return false
