class Movie < ActiveRecord::Base

	## Relations
	has_many :movie_genres
	has_many :genres, through: :movie_genres
	has_many :ratings
	has_many :users, through: :ratings, source: :user

	## Functions
	def recommended_movies
		# returns item based recommendation
		Movies.all
	end
end
