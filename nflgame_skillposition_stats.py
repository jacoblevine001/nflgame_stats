import nflgame
from collections import defaultdict

wr = defaultdict(int)
qb = defaultdict(int)
rb = defaultdict(int)

def qb_stats(s,w,t):
    # methods made to find the number of yds caught before a td for a wr. 
    # can be found in "qb_yds_until_td.csv"
    game = nflgame.games(s, w, t)
    play = nflgame.combine_plays(game).filter(passing_yds=lambda v: v > 1)
    for p in play:
        for player in p.players.passing():
            qb[player.name] += player.passing_yds
            if player.passing_tds == 1:
                msg = "%s,%d\n"
                return msg % (player.name, qb[player.name])
                qb[player.name] = 0

def wr_stats(s,w,t):
    # methods made to find the number of yds caught before a td for a wr. 
    # can be found in "wr_yds_until_td.csv"
    game = nflgame.games(s, w, t)
    play = nflgame.combine_plays(game).filter(passing_yds=lambda v: v > 1)
    for p in play:
        for player in p.players.receiving():
            wr[player.name] += player.receiving_yds
            if player.receiving_tds == 1:
                msg = "%s,%d\n"
                return msg % (player.name, wr[player.name])
                wr[player.name] = 0  
                
def rb_stats(s,w,t):
    # methods made to find the number of yds caught before a td for a wr. 
    # can be found in "rb_yds_until_td.csv"
    game = nflgame.games(s, w, t)
    play = nflgame.combine_plays(game).filter(passing_yds=lambda v: v < 1)
    for p in play:
        for player in p.players.rushing():
            rb[player.name] += player.rushing_yds
            if player.rushing_tds == 1:
                msg = "%s,%d\n"
                return msg % (player.name, rb[player.name])
                rb[player.name] = 0 

seasons = [2009,2010,2011,2012,2013,2014,2015,2016]
weeks = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
teams = [
      'ARI','ATL','BAL','BUF','CAR','CHI','CIN',
     'CLE','DAL','DEN','DET', 'GB','HOU','IND',
     'JAC','KC','LA','MIA','MIN','NE','NO','NYG',
     'NYJ','OAK','PHI','PIT','SD','SEA','SF',
     'STL','TB','TEN','WAS',
]

f1=open('qb_yds_until_td.csv', 'w+')
f1.write("QB, Yards Passed Until TD\n")
print "Creating file qb_yds_until_td.csv"
for s in seasons:
    print "...loading data from ", s, "..."
    for w in weeks:
        for t in teams:
            try:    
                f1.write(qb_stats(s,w,t))
            except TypeError:
                continue
f1.close()
print "file qb_yds_until_td.csv complete"

f2=open('wr_yds_until_td.csv', 'w+')
f2.write("WR, Yards Rec Until TD\n")
print "Creating file wr_yds_until_td.csv"
for s in seasons:
    print "...loading data from ", s, "..."
    for w in weeks:
        for t in teams:
            try:    
                f2.write(wr_stats(s,w,t))
            except TypeError:
                continue
f2.close()
print "file wr_yds_until_td.csv complete"

f3=open('rb_yds_until_td.csv','w+')
f3.write("RB, Yards Rushed Until TD\n")
print "Creating file rb_yds_until_td.csv"
for s in seasons:
    print "...loading data from ", s, "..."
    for w in weeks:
        for t in teams:
            try:    
                f3.write(rb_stats(s,w,t))
            except TypeError:
                continue
f3.close()
print "file rb_yds_until_td.csv complete"
