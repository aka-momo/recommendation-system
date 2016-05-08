class ItemBased < RecommenderBase

  def self.recommend_for(user, movie)
    similar_movies_ids = find_similar_movies_for(movie)
    Movie.joins(:ratings).where(ratings: {movie_id: similar_movies_ids}).where.not(ratings: {user_id: user.id}).order("ratings.score desc").group(:id) 
  end

  def self.find_similar_movies_for(movie)
    sim2d = ratings_matrix_for_movie(movie) * _v * _s.inverse
    movie_sim = {}

    _u.rows.each_with_index do |x, index|
      sim = (sim2d.transpose.dot(x.transpose)) / (x.norm * sim2d.norm)
      movie_sim[index] = (sim.nan? or sim.nil?) ? 0 : sim
    end
      
    movie_sim.delete_if{ |k, sim| sim < SIMILARITY_THRESHOLD }.sort{ |x, y| y[1] <=> x[1] }.first(TOP_SIMITLAR)
  end

  def self.ratings_matrix_for_movie(movie)
    user_ids    = User.order('id asc').pluck(:id)
    ratings     = movie.ratings.to_a.group_by(&:user_id)
    ratings_row = []
    user_ids.first(self.user_count).each do |user_id|
      ratings_row << (ratings[user_id].nil? ? 0 : ratings[user_id].first.score)
    end
    Linalg::DMatrix[ratings_row]
  end
end
