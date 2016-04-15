class MoviesController < ApplicationController
  def index
  	@movies = Movie.all;
  	# Movies.recommended_movies;
  end

  def show
  	@movies = movies.find(params[:id]);
  	@recommended_movies = movies.recommended_movies;
  end
end
