dkanr_setup(url = 'https://datacatalog.worldbank.org/')
metadata <- retrieve_node(nid ='140177', as = 'list')
metadata_rs_dkan <- retrieve_node(nid ='140366', as = 'list')
metadata_rs_api <- retrieve_node(nid ='140413', as = 'list')


# Save data ---------------------------------------------------------------

devtools::use_data(metadata,
                   metadata_rs_dkan,
                   metadata_rs_api,
                   internal = FALSE,
                   overwrite = TRUE)
