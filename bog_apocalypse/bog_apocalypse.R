library(ggplot2)

data <- read.table('simulation1.csv', header=TRUE, sep=',')

# The first parameter is the data, while the second indicates whether to apply the
# func­tion by rows (1) or by columns (2). In our case, we are applying it by columnn,
# so we use the parameter 2. The last parameter is the name of the function to call.
mean <- apply(data, 2, mean)
median <- apply(data, 2, median)
max <- apply(data, 2, max)

# Create a data frame from the vectors above, with a population sequence.
df <- data.frame(population=seq(from=10, to=600, by=10), mean=mean, median=median, max=max)

# Plot mean, median and max queue size against population, both line and point plots.
ggplot(data = df) + scale_shape_manual(name='Type', values=c(2, 3, 4)) +
  geom_smooth(aes(x = population, y = mean)) +
  geom_point(aes(x = population, y = mean, shape = 'mean')) +
  geom_smooth(aes(x = population, y = median)) +
  geom_point(aes(x = population, y = median, shape = 'median')) +
  geom_smooth(aes(x = population, y = max)) +
  geom_point(aes(x = population, y = max, shape = 'max')) +
  scale_y_continuous('queue size', breaks=0:35) +
  scale_x_continuous('population', breaks=seq(from=10, to=600, by=30))

