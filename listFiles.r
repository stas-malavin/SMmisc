listFiles <- function(Dir = NULL, Out = FALSE, Num = TRUE, Sep = ".", Show = FALSE, pathOut = file.path(dirname(Dir), paste(basename(Dir), "files_list.txt", sep = "_")))
{
	if (is.null(Dir)) {
			Dir <- choose.dir()
			lf <- list.files(Dir)
	} else lf <- list.files(Dir)
	if (Out == F) return(lf) else {
			if (Num == T) {tlf <- data.frame(paste(1:length(lf), Sep, sep = ""), lf)
				} else tlf <- data.frame(lf)
			write.table(tlf, pathOut, col.name = F, row.name = F, quote = F)
			if (Show == T) file.show(pathOut)
	}
}