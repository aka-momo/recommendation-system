class Rating < ActiveRecord::Base


	## Relations
	belongs_to :user
	belongs_to :movie

	## Functions
	
end
