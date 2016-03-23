pairsBySubsets <- function(df, n = 1, permanent = FALSE, method = "pearson", pdf = FALSE, pdfName = "pairsBySubsets(df).pdf", ...)
# 'pairs' function for large datasets where full data plotting isn't readable
# df		Data frame
# n			Number of subsets (groups of columns) desired
# permanent	Number of column of interest (e.g. dependent variable) wanted in each subset (e.g. 1 or length(df) #the last column)
# method	Is transferred to 'cor': "spearman" or "kendall"; "pearson" is default
# TODO/FIX	Remove mess with 'options', define subscrpt more precisely to avoid errors, allow definition of 'permanent' by name,
# 			each page in separate device (???), page numeration, !!! Clean-up !!!, naming of pdf file after df argument's name
{
	par(ask = T)
	options(warn = 0)
	panel.cor <- function(x, y, digits = 2, prefix = "", cex.cor, ...)
	{
		usr <- par("usr")
		par(usr = c(0, 1, 0, 1))
		r <- abs(cor(x, y, method = method))
		txt <- format(c(r, 0.123456789), digits = digits)[1]
		txt <- paste0(prefix, txt)
		if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
		text(0.5, 0.5, txt, cex = cex.cor * r)
		par(usr)
	}
	if (pdf) {
		pdf(file = pdfName, paper = "a4r", width = 12, height = 7)
		par(ask = F)
	}
	for (i in 0:(n-1)) {
		subscrpt <- seq_len(ceiling(length(df)/n))+ceiling(length(df)/n)*i
		if (permanent) {
			df.tmp <- df[,c(subscrpt[subscrpt <= length(df) & subscrpt != permanent], permanent)]
		} else { 
			df.tmp <- df[,subscrpt[subscrpt <= length(df)]]
		}
		pairs(df.tmp, upper.panel = panel.smooth, lower.panel = panel.cor, ...)
	}
	if (names(dev.cur()) != "windows") dev.off()
	par(ask = F)
	options(warn = 1)
}