/// tw_api_response_cleanup()
// Cleans up after HTTP response handling.

if ds_exists(jsonmap, ds_type_map) {
    ds_map_destroy(jsonmap)
    jsonmap = -1
}
