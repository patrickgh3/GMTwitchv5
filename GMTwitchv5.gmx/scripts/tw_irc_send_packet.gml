/// tw_irc_send_packet(str)
// Sends a string over the network connection.

var packetBuf = buffer_create(1024, buffer_grow, 1)
buffer_seek(packetBuf, buffer_seek_start, 0)
buffer_write(packetBuf, buffer_string, argument0 + chr(13)/*CR*/ + chr(10)/*LF*/)
network_send_raw(ircsocket, packetBuf, buffer_get_size(packetBuf))
buffer_delete(packetBuf)
