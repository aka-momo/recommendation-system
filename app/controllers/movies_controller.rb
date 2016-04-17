class MoviesController < ApplicationController

	# Filters
	before_action :prepare_movie, only: [:rate, :show]

  def index
  	if params[:genre].blank?
  		@movies = Movie.page(params[:page]).per(10)
  	else
  		@movies = Movie.joins(:genres).where(genres: {name: params[:genre]}).page(params[:page]).per(10)
  	end
  end

  def show
  	@recommended_movies = @movie.recommended_movies(current_user)
  end

  def rate
  	current_user.rate!(@movie, params[:score])
  	render json: {}
  end

  def prepare_movie
  	@movie = Movie.find(params[:id])
  end
end
