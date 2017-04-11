/// tw_irc_send_message(message)
// Sends a Twitch chat message.

tw_irc_send_packet('PRIVMSG #' + ircchannelname + ' :' + argument0)
