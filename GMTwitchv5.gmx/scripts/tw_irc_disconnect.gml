/// tw_irc_disconnect()
// Disconnects from Twitch chat. Sets ircconnected, ircsocket.

if not ircconnected {
    show_debug_message('Warning: trying to disconnect when already disconnected')
    return false
}

tw_irc_send_packet('QUIT :' + 'Bye')
network_destroy(ircsocket)
ircsocket = -1
ircconnected = false
