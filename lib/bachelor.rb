require 'json'
require 'pry'

# data = File.read('spec/fixtures/contestants.json')
# data_hash = JSON.parse(data)       

def get_first_name_of_season_winner(bachelor, season)
  winner = bachelor[season].find do |contestant|
    contestant["status"] == "Winner"
  end
  winner["name"].split(' ').first
end

#HELPER METHOD!!!
def get_contestants(bachelor)
  #return all contestants == array of hashes
  #In the pipes, we could replace season with _ (key) as a convention 
  #it's just a placeholder since we're not using it
  #all_contestants is our accumulator name
 
  # bachelor.reduce([]) do |all_contestants, (season, contestants)|
  #   all_contestants + contestants
  # end
  bachelor.map { |_, contestants| contestants }.flatten
end


def get_contestant_name(bachelor, occupation)
  all_contestants = get_contestants(bachelor)
  
  contestant_with_occupation = all_contestants.find do |contestant|
    contestant["occupation"] == occupation
  end
  contestant_with_occupation["name"]
end

def count_contestants_by_hometown(bachelor, hometown)
  # contestants_same_hometown = 0
  # get_contestants(bachelor).each do |contestant|
  #   contestants_same_hometown += 1 if contestant["hometown"] == hometown
 
  # get_contestants(bachelor).reduce(0) do |number_from_hometown, contestant|
  #   if contestant["hometown"] == hometown
  #     number_from_hometown + 1
  #   else
  #     number_from_hometown
  #   end
  # end
   
    # contestants_same_hometown (this is part of .each method)

    #select always returns an array
  contestants_with_hometown = get_contestants(bachelor).select do |contestant|
    contestant["hometown"] == hometown
  end
  contestants_with_hometown.length
end

def get_occupation(bachelor, hometown)
  contestant_occupation = get_contestants(bachelor).find do |contestant|
    contestant["hometown"] == hometown
  end
  contestant_occupation["occupation"]
end

def get_average_age_for_season(data, season)
  total_age = 0
  number_of_contestants = 0

  data[season].each do |contestant|
    total_age += (contestant["age"]).to_i
    number_of_contestants += 1
  end
  (total_age / number_of_contestants.to_f).round(0)
end
