# what would I do without you Yihui -- http://yihui.name/knitr/demo/wordpress/
if (!require('RWordPress'))
  install.packages('RWordPress', repos = 'http://www.omegahat.org/R', type = 'source')
library(RWordPress)
library(knitr)

# set you username and password below
options(WordpressLogin = c(username = 'password'),
        WordpressURL = 'http://baseballwithr.wordpress.com/xmlrpc.php')

knit2wp(input = 'index.Rmd',            # name of Rmd file to knit
        title = 'Give me a title!',     # put title here as opposed to within in the Rmd file
        categories = c('R', 'pitchRx'),
        shortcode = c(TRUE, TRUE),      # ensures proper code highlighting
        publish = FALSE)

# Since publish = FALSE, the post was not yet published.
# This way we can preview before publishing
browseURL("http://baseballwithr.wordpress.com/wp-admin/edit.php")
