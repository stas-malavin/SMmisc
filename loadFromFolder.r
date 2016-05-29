loadFromFolder <- function(path)
# Loads objects (lists are supposed) from a folder, then concatenates them
# Value : A list of concatenated loaded objects
{
  require(magrittr)
  L <- list()
  files <-
    list.files(path, full.names = T) %>%
    grep('\\.rda[ta]?', ., ignore.case = T, value = T)
  for (i in files) {
    L <- load(i) %>% get %>% c(L)
  }
  return(L)
}
