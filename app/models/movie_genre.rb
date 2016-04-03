class MovieGenre < ActiveRecord::Base

	## Relations
	belongs_to :movie
	belongs_to :genre

	## Functions
end
