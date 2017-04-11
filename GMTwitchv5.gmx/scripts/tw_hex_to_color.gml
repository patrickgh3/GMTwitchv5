/// tw_hex_to_color(str)
// Converts string in format "FFFFFF" to a gamemaker color value.

var hexColorStr = argument0
var hexColorDigits;
for (var hexI = 0; hexI < 6; hexI++) {
    hexColorDigits[hexI] = string_pos(string_char_at(hexColorStr, hexI+1), '0123456789ABCDEF') - 1
}
return make_colour_rgb(
    hexColorDigits[0]*16+hexColorDigits[1],
    hexColorDigits[2]*16+hexColorDigits[3],
    hexColorDigits[4]*16+hexColorDigits[5])
