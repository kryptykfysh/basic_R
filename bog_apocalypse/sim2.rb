# Where sim.rb changes the population on a fixe dnumber of facilites, this
# this model changes the number of facilities for a fixed population.
require 'csv'
require_relative './restroom'

frequency = 3
use_duration = 1
population_size = 1_000
facilities_per_restroom_range = 1..30
DURATION = 9 * 60
data = {}

facilities_per_restroom_range.each do |facilities_per_restroom|
  Person.population.clear
  population_size.times { Person.population << Person.new(frequency, use_duration) }
  data[facilities_per_restroom] = []
  restroom = Restroom.new facilities_per_restroom

  DURATION.times do |t|
    queue = restroom.queue.clone
    restroom.queue.clear
    data[facilities_per_restroom] << queue.size
    restroom.enter queue.shift unless queue.empty?

    Person.population.each do |person|
      restroom.enter person if person.need_to_go?
    end

    restroom.tick
  end
end

CSV.open('simulation2.csv', 'w') do |csv|
  lbl = []
  facilities_per_restroom_range.each do |facilities_per_restroom|
    lbl << facilities_per_restroom
  end
  csv << lbl

  DURATION.times do |t|
    row = []
    facilities_per_restroom_range.each do |facilities_per_restroom|
      row << data[facilities_per_restroom][t]
    end
    csv << row
  end
end
