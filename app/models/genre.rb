class Genre < ActiveRecord::Base

	## Relations
	has_many :movie_genres
	has_many :movies, through: :movie_genres

	## Functions

end
