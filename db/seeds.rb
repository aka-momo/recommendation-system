# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#   Post.create({:id => 10, :title => 'Test'}, :without_protection => true)
#
#	ActiveRecord::Base.transaction do
#	  david.withdrawal(100)
#	  mary.deposit(100)
#	end


# user = User.new do |u|
# 	u.name = "Test User"
# 	u.email = "test@recsys.com"
# 	u.password = "123456"
# end

# user.save

# genre = Genre.new do |g|
# 	g.name = "Action"
# end

# genre.save

# movie = Movie.new do |m|
# 	m.name = "Horrible Bosses (2015)"
# end

# movie.save


# movie_genre = MovieGenre.new do |mg|
# 	mg.movie = movie
# 	mg.genre = genre
# end

# movie_genre.save

# rating = Rating.new do |r|
# 	r.user = user
# 	r.movie = movie
# 	r.score = 5
# end

# rating.save


# data_path          = "db/data"
# genres_path        = data_path + "/genres.dat"
# movies_path        = data_path + "/movies.dat"
# ratings_path       = data_path + "/ratings.dat"
# genre_name_hash = {}

# def print_title_message(msg)
# 	separator = "-"*100
# 	puts "#{separator}
# 		[#{msg}]\n#{separator}"
# end


# puts "Importing Genres"
# g_strings = File.read(genres_path).split("\n")

# ActiveRecord::Base.transaction do
# 	g_strings.each {|gs| Genre.create(name: gs)}
# end

# Genre.all.each {|g| genre_name_hash[g.name] = g}
# print_title_message("#{Genre.count} Genres imported")


# puts "Importing Movies"
# movies_array = File.read(movies_path).lines.map{|l| l.gsub("\n", "").split("::") }
# ActiveRecord::Base.transaction do
# 	movies_array.each do |m|
# 		movie = Movie.new({id: m[0], name: m[1]}, :without_protection => true)
# 		movie.save
# 		movie.genres << m[2].split("|").map {|gn| genre_name_hash[gn]}
# 	end
# end
# movies_array = nil
# print_title_message("#{Movie.count} Movies imported")

# puts "Importing Ratings"
# ratings_array = File.read(ratings_path).lines.map{|l| l.gsub("\n", "").split("::") }
# ActiveRecord::Base.transaction do
# 	ratings_array.each do |r|
# 		rating = Rating.new({user_id: r[0], movie_id: r[1], score: r[2]} , :without_protection => true)
# 		rating.save
# 	end
# end
# ratings_array = nil
# print_title_message("#{Rating.count} Ratings imported")


puts "Importing Users"
ActiveRecord::Base.transaction do
	users_hash = Rating.pluck(:id).uniq.each do |id|
		u = User.new({id: id, password: "123456", email: "#{id}@rs.com", name: id.to_s}, :without_protection => true)
		u.save
	end
end
print_title_message("#{User.count} Users imported")
