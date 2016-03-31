batch_changes <- function(search.pattern, replacement, files = tk_choose.files(), xpath = T)
# Arguments:
# search.pattern	Currently a character vector.
# replacement		A vector of replacements.
# xpath 		If TRUE, accepts XPath expressions as the search
#			pattern. In this case 'replacement' should be a call
#			to, e.g., xmlNode() or xmlAttrs().
# file			The stub.
{
require(tcltk)
if (xpath) {
   require(XML)
   for (file in files) {
      stub <- htmlParse(file)

   }
   write(stub, file = file)
} else {
   for (file in files) {
      stub <- readLines(file)
      for (i in 1:length(replacement)) {
         stub <- gsub(search.pattern[i], replacement[i], stub)
      }
      write(stub, file = file)
   }
}
}
