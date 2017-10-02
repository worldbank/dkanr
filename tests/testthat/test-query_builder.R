context('query_builder')

# Define constant values
demo_url = 'http://demo.getdkan.com/'
node_title = 'U.S. Adult Smoking Rate'
node_type = 'resource'
node_lang = 'und'
node_field = c('nid')
node_fields = c('nid', 'uri', 'type')
node_page = 1
node_pagesize = 10

# Test filters_to_text_query
  test_that('Single filters are correctly built', {
    expect_equal(
        filters_to_text_query(filters = c(title = node_title)),
                              'parameters[title]=U.S. Adult Smoking Rate')
  })


  test_that('Multiple filters are correctly built', {
    expect_equal(
    filters_to_text_query(filters = c(title = node_title,
                                      type = node_type,
                                      language = node_lang)),
                          'parameters[title]=U.S. Adult Smoking Rate&parameters[type]=resource&parameters[language]=und')
  })


# Test build_search_query
  test_that('Spaces are correctly handled', {
    expect_equal(
      build_search_query(fields = NULL,
                         filters = c(title = node_title),
                         pagesize = NULL,
                         page = NULL),
      'parameters[title]=U.S.%20Adult%20Smoking%20Rate')
  })

  test_that('Single fields are correctly built', {
    expect_equal(
      build_search_query(fields = node_field,
                         filters = NULL,
                         pagesize = NULL,
                         page = NULL),
      'fields=nid')
  })

  test_that('Multiple fields are correctly built', {
    expect_equal(
      build_search_query(fields = node_fields,
                         filters = NULL,
                         pagesize = NULL,
                         page = NULL),
      'fields=nid,uri,type')
  })

  test_that('Single field & single filter are correctly built', {
    expect_equal(
      build_search_query(fields = node_field,
                         filters = c(title = node_title),
                         pagesize = NULL,
                         page = NULL),
      'fields=nid&parameters[title]=U.S.%20Adult%20Smoking%20Rate')
  })

  test_that('Multiple fields & multiple filters are correctly built', {
    expect_equal(
      build_search_query(fields = node_fields,
                         filters = c(title = node_title,
                                     type = node_type,
                                     language = node_lang),
                         pagesize = NULL,
                         page = NULL),
      'fields=nid,uri,type&parameters[title]=U.S.%20Adult%20Smoking%20Rate&parameters[type]=resource&parameters[language]=und')
  })

  test_that('Page size is built correctly', {
    expect_equal(
      build_search_query(fields = NULL,
                         filters = NULL,
                         pagesize = node_pagesize,
                         page = NULL),
      'pagesize=10')
  })

  test_that('Page size is built correctly', {
    expect_equal(
      build_search_query(fields = NULL,
                         filters = NULL,
                         pagesize = NULL,
                         page = node_page),
      'page=1')
  })

  test_that('All parameters combined build correctly', {
    expect_equal(
      build_search_query(fields = node_fields,
                         filters = c(title = node_title,
                                     type = node_type,
                                     language = node_lang),
                         pagesize = node_pagesize,
                         page = node_page),
      'fields=nid,uri,type&parameters[title]=U.S.%20Adult%20Smoking%20Rate&parameters[type]=resource&parameters[language]=und&pagesize=10&page=1')
  })
