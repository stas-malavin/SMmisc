filesFromStub <- function(search.pattern, replacement, file = tk_choose.files(), xpath = T, newFiles = paste(seq(1,length(replacement)), 'html', sep= '.'))
# The goal is to make several different files from one stub.
# Arguments:
# search.pattern	Currently a character vector
# replacement		A list of vectors with replacements for each file.
#			Each element should be the same length with
#			'search.pattern'.
# xpath 		If TRUE, accepts XPath expressions as the search
#			pattern. In this case 'replacement' should be a call
#			to, e.g., xmlNode() or xmlAttrs().
# file			The stub.
# newNames		Names for resulting files.
{
sapply(c('XML', 'tcltk'), require, character = T)
stub <- readLines(file)
# if (xpath)
for (i in 1:length(replacement)) {
  html <- stub
  for (j in 1:length(search.pattern)) {
    html <- gsub(search.pattern[j], replacement[[i]][j], html)
  }
  write(html, file = newFiles[i])
}
}


