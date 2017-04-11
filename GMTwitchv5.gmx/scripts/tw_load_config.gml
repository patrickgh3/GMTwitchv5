/// tw_load_config(configfilename)
/* Reads Twitch config file. Sets ircusername, ircpassword, clientid.
The file should be formatted as follows:

botusername
oauth:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
clientidclientidclientid
*/

var configFilename = argument0

if file_exists(configFilename) {
    var f = file_text_open_read(configFilename)
    ircusername = file_text_read_string(f)
    file_text_readln(f)
    ircpassword = file_text_read_string(f)
    file_text_readln(f)
    clientid = file_text_read_string(f)
    file_text_close(f)
}
else {
    show_debug_message('Twitch config file '+configFilename + " doesn't exist!")
}
