class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	## Relations
	has_many :ratings
	has_many :movies, through: :ratings, source: :movie

	## Functions

	def recommended_movies
		# returns user based recommendation
		UserBased.recommend_for(self)
	end

	def rate!(movie, score)
		# Order to rate
		if rating = rating_for_movie(movie)
			rating.update(score: score)
		else
			self.ratings << Rating.new(movie_id: movie.id, score: score)
		end
		
	end

	def rated?(movie) 
		Rating.exists?(movie_id: movie.id)
	end

	def rating_for_movie(movie)
		ratings.find_by(movie_id: movie.id)
	end

	def rating_for_movie_or_zero(movie)
		if rating = rating_for_movie(movie)
			rating.score
		else
			0
		end
	end
end
