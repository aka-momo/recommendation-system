class UserBased < RecommenderBase
  
  def self.recommend_for(user)
    similar_users_ids = find_similar_users_for(user)
    Movie.joins(:ratings).where(ratings: {user_id: similar_users_ids}).where.not(ratings: {user_id: user.id}).order("ratings.score desc").group(:id)
  end

  def self.find_similar_users_for(user)
    sim2d = ratings_matrix_for_user(user) * _u * _s.inverse
    user_sim = {}

    _v.rows.each_with_index do |x, index|
      sim = (sim2d.transpose.dot(x.transpose)) / (x.norm * sim2d.norm)
      user_sim[index] = (sim.nan? or sim.nil?) ? 0 : sim
    end
      
    user_sim.delete_if{ |k, sim| sim < SIMILARITY_THRESHOLD }.sort{ |x, y| y[1] <=> x[1] }.first(TOP_SIMITLAR)
  end

  def self.ratings_matrix_for_user(user)
    movie_ids   = Movie.order('id asc').pluck(:id)
    ratings     = user.ratings.to_a.group_by(&:movie_id)
    ratings_row = []
    movie_ids.each do |movie_id|
      ratings_row << (ratings[movie_id].nil? ? 0 : ratings[movie_id].first.score)
    end
    Linalg::DMatrix[ratings_row]
  end
end
