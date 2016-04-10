class Movie < ActiveRecord::Base

	## Relations
	has_many :movie_genres
	has_many :genres, through: :movie_genres
	has_many :ratings
	has_many :users, through: :ratings, source: :user

	## Functions
	def recommended_movies(user)
		# returns item based recommendation
		ItemBased.recommend_for(user, self)
	end
end
