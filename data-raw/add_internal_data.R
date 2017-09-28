# JSON body for system_onnect
system_connect_json <- jsonlite::fromJSON('data-raw/system_connect.json')

# JSON body for login_service

login_service_json <- jsonlite::fromJSON('data-raw/login_service.json')

# Save data ---------------------------------------------------------------

devtools::use_data(system_connect_json,
                   login_service_json,
                   internal = TRUE,
                   overwrite = TRUE)
