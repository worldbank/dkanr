## ----message=FALSE, warning=FALSE, paged.print=FALSE, eval=FALSE---------
#  dkanr_setup(url = 'http://demo.getdkan.com',
#              username = 'my_username',
#              password = 'my_password)

## ----echo=TRUE, message=FALSE, warning=FALSE, paged.print=FALSE----------
get_url()
get_cookie()
get_token()

## ----echo=TRUE, message=FALSE, warning=FALSE, paged.print=FALSE----------
# Retrieve metadata as JSON
retrieve_node('35', as = 'json')

# Retrieve metadata as R dkan_node object
retrieve_node('35', as = 'list')

