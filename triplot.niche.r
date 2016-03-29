triplot.niche <- function (niche, sites = "p", species = "t", factors = c("a", "t"), k = 1,	lab.site = 1:nrow(niche$ls), lab.spec = names(niche$lw), lab.fac = row.names(niche$c1),	pch.site = 1, pch.spec = "+", zero.lines = TRUE)
# Plots sites and species scores from ade4 niche object together with factors arrows on the same graph
# ARGUMENTS: 
# sites			How sites should be drawn
# species		How species should be drawn
# factors		How factors should be drawn
# 				"p" - points, "t" - text, "a" - arrows; combinations allowed. Any other value abandons plotting
# k				Coefficient for manually adjusting arrows length. Real in [0; 1]
# lab.xxx		A character vector for labeling xxx
# pch.xxx		Either a character or integer vector for plotting points of xxx (see ?par; ?points)
# zero.lines	Should zero axes be plotted?
# Note that a biplot method is determined for the niche object. See ?biplot
{
	if (!inherits(niche, "niche")) 
        stop("Object of class niche expected")
	# Extracting normed scores from niche object
	sp <- niche$l1
	si <- niche$ls
	# Scaling arrows
	## Determining which of species and sites a user wants to plot (args != "n") and making a temporal matrix M of their coords
	M1 <- c(si, sp)[rep( c(sites, species)!=c("n", "n"), each = 2)]
	M <- cbind(unlist(c(M1[1], M1[3])), unlist(c(M1[2], M1[4])))
	## Increasing arrows up to the maximum plotting value
	m <- ceiling(max(abs(M)) / max(abs(niche$c1)))
	ar <- niche$c1 * m * k
	# Preparing canvas
	## Finding maximal dimensions for plotting area (depends on what is plotted - sites, species, or both)
	M <- rbind(M, as.matrix(ar))
	xlim = range(M[ ,1])
	ylim = range(M[ ,2])
	plot.new()
	plot.window(xlim = xlim, ylim = ylim)
	box()
	if (zero.lines == T) {
		abline(h = 0, lty = 2)
		abline(v = 0, lty = 2)
	}
	# Drawing arrows with neatly alligned labels
	## Labels positioned below arrows' points for arrows in lower semiplain and above for those in upper semiplain
	pos <- numeric(nrow(ar))
	pos[ar[ ,2] > 0] <- 3
	pos[ar[ ,2] < 0] <- 1
	## Plotting arrows and labels
	if ("a" %in% factors) arrows(0, 0, ar[ ,1], ar[ ,2], length = 0.08)
	if ("t" %in% factors) text(ar[ ,1], ar[ ,2], labels = lab.fac, pos = pos, offset = 0.2)
	# Adding sites and species
	if ("t" %in% sites) text(si[ ,1], si[ ,2], labels = lab.site, cex = 0.8)
	if ("p" %in% sites) points(si[ ,1], si[ ,2], pch = pch.site)
	if ("p" %in% species) points(sp[ ,1], sp[ ,2], pch = pch.spec)
	if ("t" %in% species) text(sp[ ,1], sp[ ,2], labels = lab.spec, cex = 0.7)
}