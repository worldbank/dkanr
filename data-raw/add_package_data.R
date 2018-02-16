dkanr_setup(url = 'https://datacatalog.worldbank.org/')
metadata <- retrieve_node(nid ='140177', as = 'list')


# Save data ---------------------------------------------------------------

devtools::use_data(metadata,
                   internal = FALSE,
                   overwrite = TRUE)
