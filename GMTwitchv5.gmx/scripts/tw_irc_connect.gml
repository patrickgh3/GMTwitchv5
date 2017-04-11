/// tw_irc_connect(username, passsword, channel)
// Connects to Twitch chat. Sets ircconnected, ircsocket, ircusername, ircpassword, ircchannelname
// Returns true if connection was successful, else false.

if ircconnected {
    show_debug_message('Warning: trying to connect when already connected')
    return false
}

// Create network connection
ircsocket = network_create_socket(network_socket_tcp)
if ircsocket < 0 {
    show_debug_message('Failed to create TCP socket.')
    ircsocket = -1
    return false
}

var serverip = 'irc.chat.twitch.tv'
var serverport = 6667
var success = network_connect_raw(ircsocket, serverip, serverport)
if success < 0 {
    show_debug_message('Failed to connect to Twitch.')
    network_destroy(ircsocket)
    ircsocket = -1
    return false
}

// Send IRC startup messages
ircusername = string_lower(argument0)
ircpassword = argument1
ircchannelname = string_lower(argument2)

tw_irc_send_packet('PASS ' + ircpassword)
tw_irc_send_packet('NICK ' + ircusername)
tw_irc_send_packet('JOIN #' + ircchannelname)
tw_irc_send_packet('CAP REQ :twitch.tv/tags')

ircconnected = true
return true
