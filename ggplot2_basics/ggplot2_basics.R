library(ggplot2)

# Really basic scatterplot of engine size (displ) against highway mileage
# (hwy) from data in ggplot2's 'mpg' dataset.
qplot(displ, hwy, data=mpg)

# Add year of manufacture as a factor
qplot(displ,hwy, data=mpg, shape=factor(year))

# Building up a plot using layers
# A layer consists of five elements:
# Data
# Aesthetic Mapping (aes)
# Statistical Transformation (stat)
# Geometric Object (stat) - type of plot
# Position Adjustment
p <- ggplot()
p + geom_point(data=mpg, aes(displ, hwy, shape=factor(year)))

# Scatterplot of city against highway mileage, with jitter to avoid points overlapping.
p <- ggplot(mpg)
p + geom_point(aes(cty, hwy), position='jitter')

# IMDB movie histogram
p <- ggplot(movies)
p + stat_bin(aes(year, ..count..))
# Could also use
# p + geom_histogram(aes(year))
