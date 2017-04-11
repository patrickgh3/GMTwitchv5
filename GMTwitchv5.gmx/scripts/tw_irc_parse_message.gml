/// tw_irc_parse_message(ircmessage)
// Parses an irc message string. Sets ircmessagetype.
// If chat message, also sets displayname, msg, color, moderator, subscriber, turbo, sender.

var str = argument0

ircmessagetype = 'other'
if string_count('PRIVMSG', str) > 0 {
    ircmessagetype = 'message'
    color = c_black
    displayname = '' // Includes capital letters, should include Japanese, etc. usernames too (needs testing)
    moderator = false
    subscriber = false
    turbo = false
    sender = '' // Lowercase username
    msg = ''
    
    // parse tags
    if string_char_at(str, 0) == '@' {
        var spacepos = string_pos(' ', str)
        var tagstr = string_copy(str, 2, spacepos-1)
        str = string_delete(str, 1, spacepos)
        
        while string_length(tagstr) > 0 {
            // advance string to next semicolon
            sempos = string_pos(';', tagstr)
            if sempos == 0 {
                sempos = string_length(tagstr)
            }
            var substr = string_copy(tagstr, 1, sempos-1)
            tagstr = string_delete(tagstr, 1, sempos)
        
            // separate key and value by equals
            var eqpos = string_pos('=', substr)
            var key = string_copy(substr, 1, eqpos-1)
            var val = string_copy(substr, eqpos+1, string_length(substr))
            
            switch key {
            case 'color':
                if val == '' color = c_black
                val = string_delete(val, 1, 1) // remove leading "#"
                color = tw_hex_to_color(val)
                break
            case 'display-name':
                displayname = string_copy(val, 1, string_length(val))
                break
            case 'mod':
                moderator = real(val)
                break
            case 'subscriber':
                subscriber = real(val)
                break
            case 'turbo':
                turbo = real(val)
                break
            
            case 'emotes':
            case 'id':
            case 'room-id':
            case 'sent-ts':
            case 'tmi-sent-ts':
            case 'user-id':
            case 'user-type':
                break
            }
        }
    }
    
    // parse info after the last semicolon
    var pos = string_pos(':', str)
    str = string_delete(str, 1, pos)
    var pos = string_pos('!', str)
    sender = string_copy(str, 1, pos-1)
    str = string_delete(str, 1, pos)
    var pos = string_pos(':', str)
    str = string_delete(str, 1, pos)
    
    msg = string_copy(str, 1, string_length(str))
    msg = string_replace(msg, chr(13)/*CR*/, '')
    msg = string_replace(msg, chr(10)/*LF*/, '')
    
    // This occasionally happens, haven't really investigated it
    if displayname == '' {
        displayname = sender
    }
    
    // twitchnotify sends sub messages and stuff. Haven't looked into it much
    if sender == 'twitchnotify' {
        ircmessagetype = 'twitchnotifymessage'
    }
}
else if string_count('PING', str) > 0 {
    ircmessagetype = 'ping'
    var content = string_delete(str, 1, 6)
    tw_irc_send_packet('PONG :' + content)
}
