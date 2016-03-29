list2array <- function(x)
{
	if (is.list(x)) {
		new <- array(unlist(x), dim = c(nrow(x[[1]]), ncol(x[[1]]), length(x)),
			dimnames = list(NULL, c('x','y'), names(x)))
	} else {
		if (!is.array(x)) stop('Argument is not a list, nor an array')
			else {
				new <- list(0)
				for (i in 1:dim(x)[3]) new[[i]] <- x[,,i]
				names(new) <- dimnames(x)[[3]]
			}
	}
	return(new)
}
