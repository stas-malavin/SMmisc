stComp <- function(df, stations, st = 1, inclZero = FALSE, summary = TRUE)
# Subsetting stations from a bigger data frame,
# compiling row and col sums, excluding zero taxa (optional)
# Taxa should be in names or row.names, not a separate variable

# ARGUMENTS:
# df		Data frame to be subset
# stations	Selected stations (currently numbers)
# st		Are stations in rows(1) or in columns(2)?
# inclZero	Include zero taxa or not
# summary	Include summary or not (species and specimens number)
 
# TODO:
# 1. Select stations by names
# 2. Make df optional (stations could be separate vectors or from different df's)
# 3. Add graphical representation
# 4. Excl argument to exclude rare or not abundant species
{
	if (st == 1) df <- as.data.frame(t(df))
	if (inclZero == FALSE) {
		rows <- vector('logical', length = nrow(df))
		for (i in stations) {
			rows <- rows | df[,i]!=0
		}
	} else {rows <- 1:nrow(df)}
	df <- df[rows, stations]
	if (summary) {
		df <- rbind(df,	apply(df, 2, function(x) sum(x[x>0]/x[x>0])), apply(df, 2, sum))
	}
	row.names(df)[c(nrow(df)-1, nrow(df))] <- c('N spp.', 'Sum.Abund.')
	return(df)
}
