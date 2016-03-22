Backup <- function(...)
{
	names <- match.call(expand.dots = F)$...
	for (name in names) {
		if(is.na(match(as.character(name), ls(envir = .GlobalEnv))))
			stop(as.character(name), ' - no such variable in .GlobalEnv')
		N <- ls(pattern = name, envir = .GlobalEnv)
		for (n in N[length(N):1]) {
			assign(paste0(n, '_'), get(as.character(n)),
					envir = .GlobalEnv)
		}
	}
}