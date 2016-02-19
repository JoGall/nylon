#===========================================================================#
# 04/02/15 by Joe Gallagher (joedgallagher@gmail.com)
#
# This script can be used to calibrate an automated nylon monofilament 
# encapsulation assay. The user can iterate the image analysis script,
# "nylonAnalysis.cpp", over a range of brightness thresholds to produce a
# range of possible areas of encapsulation. By comparing this data 
# subjective human scoring of the same images (e.g. using the colour
# threshold in ImageJ), this script selects the brightness threshold which
# most closely matches that chosen by the human user.

# This example reads a file containing an automated scores file,
# "result.txt", and a file containing the user-defined scores of the same
# images, "manualScores.txt", with headings 'Image' and 'encapArea'.
#===========================================================================#

#read automated and manual scores
auto <- read.table("automatedScores.txt", head=T)
manual <- read.table("manualScores.txt", head=T)

#calculate difference between manual scores
compar <- data.frame(Image = auto$Image, threshold = auto$encapThreshold, autoEncap = auto$encapArea)
compar$manualEncap <- manual$encapArea[match(compar$Image, manual$Image)]
compar$diffEncap <- abs(compar$manualEncap - compar$autoEncap)

#find best fitting threshold (minimum difference between automated and human scores)
compar[which(compar$diffEncap==min(compar$diffEncap)),]$threshold

#visualise fits of thresholds
require(ggplot)
ggplot(compar, aes(x = threshold, y = diffEncap)) +
	geom_line(stat = "summary_bin", binwidth = 0.1, fun.y = "mean") + 
	stat_smooth(method = "lm", formula = y ~ x + I(x^2), size = 1, se = FALSE, colour = "blue") + 
    stat_smooth(method = "loess", formula = y ~ x, size = 1, se = FALSE, colour = "red") + 
    stat_smooth(method = "gam", formula = y ~ s(x), size = 1, se = FALSE, colour = "green") + 
    stat_smooth(method = "gam", formula = y ~ s(x, k = 3), size = 1, se = FALSE, colour = "violet")
