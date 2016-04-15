class Movie < ActiveRecord::Base

	## Relations
	has_many :movie_genres
	has_many :genres, through: :movie_genres
	has_many :ratings
	has_many :users, through: :ratings, source: :user

	## Functions
	def self.recommended_movies
		# returns item based recommendation
		Movies.all
	end

	def overall_ratings
		[1,2,3,4,5].sample
	end
end
