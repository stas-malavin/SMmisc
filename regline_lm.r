regline_lm <- function(formula, data, model = c('lm'), interval = c('CI', 'PI'), lty.CI = 3, lty.PI = 2, col = 1, col.line = col, col.CI = col, col.PI = col, ...)
# A function plotting a neat regression (currently linear) line
# [not expanding to the data as with abline()] as well as confidence
# and prediction intervals
{
	if(missing(data)) data <- environment(formula)
	Lm <- do.call(model, list(formula))
	lines(Lm$model[,2], Lm$fitted, col = col.line)
	intervals <- match.arg(interval, several.ok = TRUE)
	if ('CI' %in% intervals) {
		pred.ci <- predict(Lm, interval = 'confidence')
		lines(sort(Lm$model[,2]), sort(pred.ci[,2]), lty = lty.CI, col = col.CI)
		lines(sort(Lm$model[,2]), sort(pred.ci[,3]), lty = lty.CI, col = col.CI)
	}
	if ('PI' %in% intervals) {
		pred.pi <- predict(Lm, interval = 'prediction')
		lines(sort(Lm$model[,2]), sort(pred.pi[,2]), lty = lty.PI, col = col.PI)
		lines(sort(Lm$model[,2]), sort(pred.pi[,3]), lty = lty.PI, col = col.PI)
	}
}
