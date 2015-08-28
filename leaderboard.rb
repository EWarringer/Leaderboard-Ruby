
class Team
  attr_accessor :name, :wins, :losses, :rank, :games
  def initialize(name)
    @name = name
    @wins = 0
    @losses = 0
    @rank = 0
    @games = []
  end

  def summary
    puts "Team Name: #{name}"
    puts "Team Rank: #{rank}"
    puts "Record (W/L): #{wins}/#{losses}\n"
  end
end

def game_info
   [
    {
      home_team: "Patriots",
      away_team: "Broncos",
      home_score: 7,
      away_score: 3
    },
    {
      home_team: "Broncos",
      away_team: "Colts",
      home_score: 3,
      away_score: 0
    },
    {
      home_team: "Patriots",
      away_team: "Colts",
      home_score: 11,
      away_score: 7
    },
    {
      home_team: "Steelers",
      away_team: "Patriots",
      home_score: 7,
      away_score: 21
    }
  ]
end

# team names
team =[]
# who won each game in order
win = []
# who lost each game in order
loss = []


game_info.each do |game|
  team << game[:home_team] if !team.include? game[:home_team]
  team << game[:away_team] if !team.include? game[:away_team]

  if game[:home_score] > game[:away_score]
    win << game[:home_team]
    loss << game[:away_team]
  else
    win << game[:away_team]
    loss << game[:home_team]
  end
end

# number of wins/losses for each team
wins = []
losses = []
# Array of objects
teams = []
scores = []

team.each do |game|
  wins << win.count(game)
  losses << loss.count(game)

  x = team.index(game)
  teams << Team.new(team[x])
  teams[x].wins = wins[x]
  teams[x].losses = losses[x]
end

# set rank in class
team.each do |game|
  x = team.index(game)
  order = wins.sort.reverse
  if order.index(wins[x]) == order.index(wins[x-1])
    teams[x].rank += order.index(wins[x])+2
  else
    teams[x].rank += order.index(wins[x])+1
  end
end

# Make array of team objects in order of ranking
teams_in_order = []
count = 1
while true
  teams.each do |team|
    teams_in_order << team if team.rank == count
  end
  break if count == teams.length
  count += 1
end


puts "-"*50
puts "| Name      Rank      Total Wins    Total Losses |"
teams_in_order.each do |x|
  print "| #{x.name}".ljust(12)
  print "#{x.rank}".ljust(14)
  print "#{x.wins}".ljust(10)
  print "#{x.losses}".ljust(13)
  puts "|"
end
puts "-"*50

teams.each {|info| puts info.summary}
