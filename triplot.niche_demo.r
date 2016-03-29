require(ade4)
data(doubs)
dudi1 <- dudi.pca(doubs$env, scale = TRUE, scan = FALSE, nf = 3)
nic1 <- niche(dudi1, doubs$fish, scann = FALSE)
source("triplot.niche.r")
# См. комментарии в тексте функции
triplot.niche
myPar <- par(ask = T)
triplot.niche(nic1, spec = "t", site = "n")
triplot.niche(nic1, spec = "t", site = "n", k = 0.6)
triplot.niche(nic1, spec = "t", site = "p")
triplot.niche(nic1, spec = "n", site = "t")
triplot.niche(nic1, spec = "p", site = "p", fact = "a", zero.line = F)
triplot.niche(nic1, spec = "p", site = "p", pch.spec = 18, pch.site = 24)
triplot.niche(nic1, spec = "t", site = "p")
mySites <- paste("Site№", 1:nrow(nic1$ls), sep = "")
triplot.niche(nic1, sites = "t", lab.site = mySites, spec = "n")
mySpec <- paste("Gen.sp.", 1:nrow(nic1$li), sep = "")
# Вместо mySites и mySpec можно использовать любые произвольные векторы,
# например, колонки с названиями станций из другой таблицы
triplot.niche(nic1, site = "n", spec = "t", lab.spec = mySpec)
par(myPar)