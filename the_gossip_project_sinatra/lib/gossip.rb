require 'bundler'
Bundler.require

class Gossip
	attr_accessor :author
	attr_accessor :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		puts @author
		puts @content
		CSV.open("/Users/BaptisteVeyrard/Desktop/THP/Semaine_4/semaine_4_jour_1/the_gossip_project_sinatra/db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return all_gossips
	end

	def self.find(id)
		i = 1
		CSV.open("./db/gossip.csv", "a+").each do |csv_line|
			if i == id.to_i
				 return Gossip.new(csv_line[0], csv_line[1])
			end
		i +=1
		end
	end

	def self.update(id, author, content)
		newgossip = []
		csv = CSV.read("./db/gossip.csv").each do |gossip|
			if gossip.include?(Gossip.id(id).content)
				newgossip << [author, content]
			else
				newgossip << gossip
			end
		end

		CSV.open('./db/gossip.csv', 'w+') do |csv_object|
			newgossip.each { |gossip|	csv_object << gossip}
		end
	end
end