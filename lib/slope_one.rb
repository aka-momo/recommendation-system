class SlopeOne
  attr_accessor :diffs, :freqs
  
  def initialize
    self.diffs = {}
    self.freqs = {}
  end

  def insert(user_data)
    user_data.each do |name, ratings|
      ratings.each do |item1, rating1|
        self.freqs[item1] ||= {}
        self.diffs[item1] ||= {}
        ratings.each do |item2, rating2|
          self.freqs[item1][item2] ||= 0
          self.diffs[item1][item2] ||= 0.0
          self.freqs[item1][item2] += 1
          self.diffs[item1][item2] += (rating1 - rating2)
        end
      end
    end
    
    self.diffs.each do |item1, ratings|
      ratings.each do |item2, rating2|
        ratings[item2] = ratings[item2] / self.freqs[item1][item2]
      end
    end
  end
  
  def predict(user)
    preds, freqs = {}, {}

    user.each do |item, rating|
      self.diffs.each do |diff_item, diff_ratings|
        next if self.freqs[diff_item].nil? or diff_ratings[item].nil?
        freq = self.freqs[diff_item][item]
        preds[diff_item] ||= 0.0
        freqs[diff_item] ||= 0
        preds[diff_item] += freq * (diff_ratings[item] + rating)
        freqs[diff_item] += freq
      end
    end
    
    results = {}
    preds.each do |item, value|
      results[item] = sprintf('%.3f', (value / freqs[item])).to_f unless user.include?(item) && freqs[item] > 0
    end
    return results
  end
end



### TEST

user_data = {
  1 => { 5 => 9.5, 3 => 8.2, 1 => 6.8 },
  2 => { 5 => 3.7, 2 => 2.1, 1 => 8.3 },
  3 => { 5 => 9.5, 3 => 3.4, 1 => 5.5, 2 => 9.3 },
  4 => { 5 => 7.2, 3 => 5.1, 1 => 8.4, 4 => 7.8,
  }
}

slope_one = SlopeOne.new
slope_one.insert(user_data)
puts slope_one.predict({1 => 3, 2 => 7.5}).inspect