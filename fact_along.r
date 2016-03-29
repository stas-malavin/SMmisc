fact_along <- function(x) sapply(x, function(y) match(y, levels(as.factor(x))))
# Creates a named vector of numeric codes for a character vector or factor
# Example
# > tmp <- c('a', 'b', 'a', 'b', 'c')
# > fact_along(tmp)
# a b a b c 
# 1 2 1 2 3 
