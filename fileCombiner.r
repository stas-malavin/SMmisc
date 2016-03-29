fileComb <- function(Dir = choose.dir(),
	outfile = file.path(Dir, 'These-files-combined.txt'))
{
	files <- dir(Dir, full = T)
	comb <- vector('list', length = length(files))
	for (i in 1:length(files)) {
		comb[[i]] <- readLines(files[i]) }
	write(unlist(comb), file = outfile)
{
