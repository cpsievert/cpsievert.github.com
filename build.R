local({
  if (!file.exists('_config.yml')) return()
  x = iconv(readLines('_config.yml', encoding = 'UTF-8'), 'UTF-8')
  baseurl = grep('^baseurl:', x, value = TRUE)
  baseurl = sub(".*['\"](.*)['\"].*", "\\1",  baseurl)
  x = grep('^markdown:\\s*[a-z]+\\s*$', x, value = TRUE)
  # see if we need to use the Jekyll render in knitr (i.e. if the markdown
  # engine is kramdown)
  if (length(x) == 0 || (length(x) == 1 && strsplit(x, ':\\s*')[[1]][2] == 'kramdown')) {
    knitr::render_jekyll()
  } else knitr::render_markdown()

  # input/output filenames are passed as two additional arguments to Rscript
  a = commandArgs(TRUE)
  d = gsub('^_|[.][a-zA-Z]+$', '', a[1])
  knitr::opts_chunk$set(
    fig.path   = sprintf('figure/%s/', d),
    cache.path = sprintf('cache/%s/', d)
  )
  # set where you want to host the figures (I store them in my Dropbox Public
  # folder, and you might prefer putting them in GIT)
  if (Sys.getenv('USER') == 'yihui') {
    # these settings are only for myself, and they will not apply to you, but
    # you may want to adapt them to your own website
    knitr::opts_chunk$set(fig.path = sprintf('%s/', gsub('^.+/', '', d)))
    knitr::opts_knit$set(
      base.dir = '~/Dropbox/Public/jekyll/',
      base.url = 'http://db.yihui.name/jekyll/'
    )
  } else {
    knitr::opts_knit$set(base.url = baseurl)
  }
  # post-process plot output to the tufte specific liquid tags
  knitr::knit_hooks$set(plot = function(x, options) {
    cap <- if (is.null(options$fig.cap)) "" else options$fig.cap
    if (isTRUE(options$fig.margin)) {
      sprintf("<span class='marginnote'><img class='fullwidth' src='%s/%s'/>%s</span>", baseurl, x, cap)
    } else if (isTRUE(options$fig.fullwidth)) {
      sprintf("<div><img class='fullwidth' src='%s/%s'/></div><p><span class='marginnote'>%s</span></p>", baseurl, x, cap)
    } else {
      # 'maincolumn' figure
      sprintf("<span class='marginnote'>%s</span><img class='fullwidth' src='%s/%s'/>", cap, baseurl, x)
    }
    # I don't think it makes sense to expose the usual html figure hook
    # If you want a figure wider than maincolumn, use fig.fullwidth
    # with appropriate fig.width
    # knitr::hook_plot_html(x, options)
  })
  knitr::opts_knit$set(width = 50)
  knitr::knit(a[1], a[2], quiet = TRUE, encoding = 'UTF-8', envir = .GlobalEnv)
})
