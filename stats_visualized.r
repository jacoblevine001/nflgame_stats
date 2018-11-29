# Looking at def data found in def_data.csv produced by def_data.py
def_data <- read.csv("~/Desktop/Desktop/def_data.csv")

# histographs of most basic included stats
hist(def_data$Sacks.by.winner)
hist(def_data$Sacks.by.loser)
hist(def_data$Sacks.by.loser,def_data$Sacks.by.winner)

plot(y=def_data$Sacks.by.winner,x=xrange,xlab="Number of Sacks",ylab = "Week",type = "p")

# looking at the statistics of one team. 
ari <- subset(def_data, subset=(Team =='ARI'))
ari <- ari[order(ari[,1], ari[,2]),] # to order ari chronologically

# single team games in order chronologically. Shows number of sack as well as coloring points green for a win and red for a loss
plot(y=ari$Sacks.by.winner, x=xrange,
	ylab="Number of Sacks", xlab = "Regular Season Games from '09-'16",type = "l", main="ARI # sacks of winning game")
points(y=ari$Sacks.by.winner, x=xrange,
	ylab="Number of Sacks", xlab = "Regular Season Games from '09-'16",type = "l", main="ARI # sacks of winning game", 
	bg=ifelse(ari$Win_Loss == "w", "green","red"),
	pch = 23)

# change win loss into 1's and 0's
# then i can look at the binom dist
win_loss <- c(ari$Win_Loss)
binomial(win_loss)

# going to need to change win -> 0 and loss -> 1

# wr data -- this is how long td passes are caught. Nice dist to look at here.
# there are some outlier games, but shows info. These are stats from 2009-2016 regular games made from wr_stats.py method
# 
wr_data <- read.csv("~/Downloads/wr_yds_until_td.csv")

# some methods to simply clean the data -- Out dated and not needed for current data set formatting
wr_data = subset(wr_data, subset=(Yards.Passed.Until.TD > 0))
wr<- wr_data[!duplicated(wr_data), ] # removed duplicate data.

# to order wr by player name to group them
wr <- wr_data[order(wr_data$WR),] 

# find max yards to set freq buckets.
max_yds <- max(wr_data$Yards.Passed.Until.TD)

histogram(wr_data$Yards.Passed.Until.TD,
	breaks=30,
	xlab="Yards Recieved Before TD", ylab="Percent of Total Data Points", main="Yards to expect until TouchDown")
hist(wr_data$Yards.Passed.Until.TD,breaks=400,
	xlab="Yards Recieved Before TD",ylab="Number of values", main="Yards to expect until TouchDown")

# looking at stats of a single wr. 
odell <-subset(wr_data, subset=(WR =='O.Beckham Jr.'))
plot(odell$Yards.Passed.Until.TD,breaks=1514,ylab="Yards Recieved Since last TD",xlab="Career TouchDowns", main="Odell Yards to expect until TouchDown", plot = "l")

# calculates the probablility of distance of yds until a td
new_odell=odell$Yards.Passed.Until.TD/sum(odell$Yards.Passed.Until.TD)
plot(odell$Yards.Passed.Until.TD,new_odell,
     xlab="Probablility of TD",ylab="Yards Until TD",main="Odell B.Jr Probability of TD in x Yards")

# calculating with all wr in data set:
new_wr <- wr_data$Yards.Passed.Until.TD/sum(wr_data$Yards.Passed.Until.TD)
plot(new_wr,wr_data$Yards.Passed.Until.TD,
     xlab="Probablility of TD",ylab="Yards Until TD",main="Probability of wr TD in x Yards")


lines(density(odell$Yards.Passed.Until.TD,new_odell),
     main = "Odell WR yards until TD Density plot",
     xlab =  "Number of yards until touchdown")

# playing wth different visualizations of this data.
# trying to overlay the histogram with the density line
histogram(wr_data$Yards.Passed.Until.TD,breaks=30,xlab="Yards Recieved Before TD",ylab="Percent of Total Data Points", main="Yards to expect until TouchDown")
hist(wr_data$Yards.Passed.Until.TD,breaks=1514,xlab="Yards Recieved Before TD",ylab="Number of values", main="Yards to expect until TouchDown")
# longest until td is 1514 yds so we can break into 1514 to bucket exactly
lines(density(wr$Yards.Passed.Until.TD, from = 0), col="blue", lwd=2)

lines(dnorm(wr$Yards.Passed.Until.TD))

plot(density(wr$Yards.Passed.Until.TD, from = 0),
     main = "WR yards until TD Density plot",
     xlab =  "Number of yards until touchdown")


# attempt to build some functions to make separate graphs for each player.
ind_player_hist <- function(n) {
  histogram(df$Yards.Passed.Until.TD,breaks=30,xlab="Yards Recieved Before TD",ylab="Percent of Total Data Points", main="Yards to expect until TouchDown")
}
relevant_wr <- c('O.Beckham Jr.','L.Fitzgerald')
for(n in relevant_wr){ ind_player_hist(n) } #need to have it out put the graphs somewhere, but this seems to be working!

