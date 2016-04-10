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
		self.ratings << Rating.new(movie_id: movie.id, score: score)
	end

	def rated?(movie) 
		Rating.exists?(movie_id: movie.id)
	end
end
