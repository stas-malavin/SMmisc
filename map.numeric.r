map.numeric <- function(x, y) {
  (x - min(x)) / (max(x) - min(x)) * (max(y) - min(y)) + min(y)
}
