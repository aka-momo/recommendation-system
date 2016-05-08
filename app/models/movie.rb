class Movie < ActiveRecord::Base

	## Relations
	has_many :movie_genres
	has_many :genres, through: :movie_genres
	has_many :ratings
	has_many :users, through: :ratings, source: :user

	## Functions
	def recommended_movies(user)
		# returns item based recommendation
		ItemBased.recommend_for(user, self) rescue Movie.random_rec
	end

	def overall_ratings
		ratings.average(:score).to_i
	end

	def number_of_ratings
		ratings.count
	end

	def genres_names
		self.genres.pluck(:name)
	end

	def photo_url
		if image_url.nil?
			download_movie_details
		else
			photo = image_url
		end
		photo ||= "movie_avatar"
		photo
	end

	def download_movie_details
		# scrap imdb
	end

	def self.random_rec
		[]
	end

end
