class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


	## Relations
	has_many :ratings
	has_many :movies, through: :ratings, source: :movie

	## Functions
end
