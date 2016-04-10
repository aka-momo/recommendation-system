class RecommenderBase

  @@_u, @@_v, @@_s     = nil, nil, nil 
  TOP_SIMITLAR         = 10
  SIMILARITY_THRESHOLD = 0.9

  def self._u
    Linalg::DMatrix.rows(JSON.parse($redis.get("u")))
  end

  def self._v
    Linalg::DMatrix.rows(JSON.parse($redis.get("v")))
  end

  def self._s
    Linalg::DMatrix.rows(JSON.parse($redis.get("s")))
  end

  def self.set_u(u)
    $redis.set("u", u.to_a)
  end


  def self.set_v(v)
    $redis.set("v", v.to_a)
  end


  def self.set_s(s)
    $redis.set("s", s.to_a)
  end

  def self.prepare_svd
    mat = prepare_ratings_matrix
    u, s, v = mat.singular_value_decomposition
    vt = v.transpose
    set_u Linalg::DMatrix.join_columns [u.column(0), u.column(1)]
    set_v Linalg::DMatrix.join_columns [vt.column(0), vt.column(1)]
    set_s Linalg::DMatrix.columns [s.column(0).to_a.flatten[0,2], s.column(1).to_a.flatten[0,2]]
  end

  def self.prepare_ratings_matrix
    user_ids  = User.order('id asc').pluck(:id)
    movie_ids = Movie.order('id asc').pluck(:id)
    ratings   = Rating.all.to_a.group_by(&:movie_id)
    rating_rows = []
    movie_ids.each do |movie_id|
      tmp = []
      rating = ratings[movie_id]
      user_ids.each do |user_id|
        tmp_r = rating.find{|r| r.user_id == user_id}
        tmp << (tmp_r.nil? ? 0 : tmp_r.score)
      end
      rating_rows << tmp
    end
    user_ids, movie_ids, ratings = nil, nil, nil
    Linalg::DMatrix.rows(rating_rows)
  end
end



