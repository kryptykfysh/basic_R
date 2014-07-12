# Load data from a csv
epl <- read.csv('2014_premiership.csv')

# Manually create vectors
team <- c('Man City', 'Man Utd', 'Totenham', 'Arsenal', 'Chelsea', 'Newcastle', 'Liverpool', 'Stoke')
home_wins <- c(14, 10, 10, 9, 8, 7, 4, 6)
home_draws <- c(0, 1, 2, 2, 2, 4, 8, 4)
home_losses <- c(0, 2, 1, 2, 3, 2, 1, 4)
away_wins <- c(7, 9, 6, 6, 5, 5, 6, 4)
away_draws <- c(3, 3, 3, 2, 5, 3, 1, 2)
away_losses <- c(3, 1, 4, 6, 4, 5, 6, 7)
# Assemble vectors in to a data frame
league_table <- data.frame(team, home_wins, home_draws, home_losses, away_wins, away_draws, away_losses)

# Merge a new vector in to a data frame, creating a new column
pts <- c(66, 61, 53, 49, 46, 43, 39, 36)
points <- data.frame(team, pts)
league <- merge(league_table, points, by='team')
# print(with(league, league[order(-pts),]))

wins <- with(epl, {
  home_wins <- HomeTeam[FTHG > FTAG]
  away_wins <- AwayTeam[FTAG > FTHG]
  sort(table(home_wins) + table(away_wins), decreasing=T)
})
#print(data.frame(wins))

# Plotting a histogram
new_wins <- league_table[c('home_wins', 'away_wins')]
par(bg='gray')
data <- t(as.matrix(new_wins))
barplot(data, names.arg=league_table$team, legend=c('home', 'away'))